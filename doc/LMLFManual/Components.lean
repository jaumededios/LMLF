import VersoManual

open Verso
open Verso.Genre Manual
open Verso.Doc Elab
open Verso.ArgParse
open Lean

namespace LMLFManual

private def lmlfCss : String := r#"
:root {
  --lmlf-ink: #152c2a;
  --lmlf-muted: #5f6d68;
  --lmlf-green: #1f5a50;
  --lmlf-green-soft: #e7f0ec;
  --lmlf-gold: #a2772d;
  --lmlf-paper: #fbfaf6;
  --lmlf-rule: #d5d8cf;
}

body {
  background: var(--lmlf-paper);
  color: var(--lmlf-ink);
}

main { max-width: 78rem; }
h1, h2, h3, h4 { color: var(--lmlf-ink); letter-spacing: -0.018em; }
a { color: var(--lmlf-green); }

.lmlf-chapter-status {
  border-top: 4px solid var(--lmlf-green);
  border-bottom: 1px solid var(--lmlf-rule);
  margin: 1.4rem 0 2rem;
  padding: 1rem 0 1.1rem;
}

.lmlf-chapter-status__eyebrow {
  color: var(--lmlf-gold);
  font-family: var(--verso-structure-font-family);
  font-size: .76rem;
  font-weight: 750;
  letter-spacing: .12em;
  text-transform: uppercase;
}

.lmlf-chapter-status__body > :first-child { margin-top: .45rem; }
.lmlf-chapter-status__footer {
  align-items: center;
  display: flex;
  flex-wrap: wrap;
  gap: .75rem;
  justify-content: space-between;
  margin-top: .8rem;
}

.lmlf-status {
  background: var(--lmlf-green-soft);
  border: 1px solid #aac1b8;
  border-radius: 999px;
  color: var(--lmlf-green);
  display: inline-block;
  font-family: var(--verso-structure-font-family);
  font-size: .72rem;
  font-weight: 700;
  letter-spacing: .055em;
  padding: .18rem .62rem;
  text-transform: uppercase;
}

.lmlf-result {
  background: #fff;
  border: 1px solid var(--lmlf-rule);
  border-left: 4px solid var(--lmlf-green);
  border-radius: .25rem;
  box-shadow: 0 5px 18px rgba(21, 44, 42, .055);
  margin: 1.35rem 0;
  overflow: hidden;
}

.lmlf-result__header {
  align-items: center;
  background: linear-gradient(90deg, #f2f7f4, #fff);
  border-bottom: 1px solid var(--lmlf-rule);
  display: flex;
  gap: 1rem;
  justify-content: space-between;
  padding: .8rem 1rem;
}

.lmlf-result__title {
  font-family: var(--verso-structure-font-family);
  font-size: 1.02rem;
  font-weight: 760;
}

.lmlf-result__body { padding: .2rem 1rem .8rem; }
.lmlf-result__body h3 { font-size: .94rem; margin-top: 1rem; }

.lmlf-lean {
  background: #f6f7f5;
  border: 1px solid var(--lmlf-rule);
  border-radius: .25rem;
  margin: .9rem 0 .2rem;
}

.lmlf-lean > summary {
  color: var(--lmlf-green);
  cursor: pointer;
  font-family: var(--verso-structure-font-family);
  font-size: .82rem;
  font-weight: 750;
  padding: .65rem .8rem;
}

.lmlf-lean[open] > summary { border-bottom: 1px solid var(--lmlf-rule); }
.lmlf-lean__body { padding: .25rem .8rem .7rem; }
.lmlf-lean__hint {
  color: var(--lmlf-muted);
  font-family: var(--verso-structure-font-family);
  font-size: .76rem;
  margin: .45rem 0 .1rem;
}

.lmlf-section-list > ul {
  columns: 2 22rem;
  column-gap: 2rem;
  list-style: none;
  padding-left: 0;
}

.lmlf-section-list li {
  break-inside: avoid;
  border-bottom: 1px dotted var(--lmlf-rule);
  padding: .28rem 0;
}

@media (max-width: 720px) {
  .lmlf-result__header { align-items: flex-start; flex-direction: column; }
  .lmlf-section-list > ul { columns: 1; }
}
"#

block_extension ResultCard (title : String) (status : String) where
  data := .arr #[.str title, .str status]
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id data contents => open Verso.Output.Html in do
    let .arr #[.str title, .str status] := data
      | reportError s!"Invalid result-card data: {data.compress}"
        return .empty
    pure {{
      <article class="lmlf-result">
        <header class="lmlf-result__header">
          <span class="lmlf-result__title">{{title}}</span>
          <span class="lmlf-status">{{status}}</span>
        </header>
        <div class="lmlf-result__body">{{← contents.mapM goB}}</div>
      </article>
    }}
  extraCss := [lmlfCss]

block_extension LeanDisclosure (label : String) where
  data := .str label
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id data contents => open Verso.Output.Html in do
    let .str label := data
      | reportError s!"Invalid Lean-disclosure data: {data.compress}"
        return .empty
    pure {{
      <details class="lmlf-lean">
        <summary>{{label}}</summary>
        <div class="lmlf-lean__body">
          <p class="lmlf-lean__hint">"Hover or focus a checked name to see its full elaborated type."</p>
          {{← contents.mapM goB}}
        </div>
      </details>
    }}
  extraCss := [lmlfCss]

block_extension ChapterStatus (sourceUrl : String) (status : String) where
  data := .arr #[.str sourceUrl, .str status]
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id data contents => open Verso.Output.Html in do
    let .arr #[.str sourceUrl, .str status] := data
      | reportError s!"Invalid chapter-status data: {data.compress}"
        return .empty
    pure {{
      <section class="lmlf-chapter-status">
        <div class="lmlf-chapter-status__eyebrow">"LMLF overlay · DLMF 1.2.7"</div>
        <div class="lmlf-chapter-status__body">{{← contents.mapM goB}}</div>
        <div class="lmlf-chapter-status__footer">
          <span class="lmlf-status">{{status}}</span>
          <a href={{sourceUrl}}>"Open the source chapter ↗"</a>
        </div>
      </section>
    }}
  extraCss := [lmlfCss]

block_extension SectionIndex where
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id _ contents => open Verso.Output.Html in do
    pure {{<nav class="lmlf-section-list">{{← contents.mapM goB}}</nav>}}
  extraCss := [lmlfCss]

structure TwoStrings where
  first : StrLit
  second : StrLit

instance : FromArgs TwoStrings DocElabM where
  fromArgs := TwoStrings.mk <$> .positional `first .strLit <*> .positional `second .strLit

structure OneString where
  value : StrLit

instance : FromArgs OneString DocElabM where
  fromArgs := OneString.mk <$> .positional `value .strLit

@[directive]
def result : DirectiveExpanderOf TwoStrings
  | { first, second }, contents => do
    ``(Block.other (ResultCard $(quote first.getString) $(quote second.getString))
      #[$(← contents.mapM elabBlock),*])

@[directive]
def leanStatement : DirectiveExpanderOf OneString
  | { value }, contents => do
    ``(Block.other (LeanDisclosure $(quote value.getString))
      #[$(← contents.mapM elabBlock),*])

@[directive]
def chapterStatus : DirectiveExpanderOf TwoStrings
  | { first, second }, contents => do
    ``(Block.other (ChapterStatus $(quote first.getString) $(quote second.getString))
      #[$(← contents.mapM elabBlock),*])

@[directive]
def sectionIndex : DirectiveExpanderOf Unit
  | (), contents => do
    ``(Block.other SectionIndex #[$(← contents.mapM elabBlock),*])

end LMLFManual
