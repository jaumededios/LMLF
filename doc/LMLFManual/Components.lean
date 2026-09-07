import VersoManual

open Verso
open Verso.Genre Manual
open Verso.Doc Elab
open Verso.ArgParse
open Lean

namespace LMLFManual

private def lmlfCss : String := r#"
:root {
  --verso-text-font-family: Georgia, "Times New Roman", serif;
  --verso-content-max-width: 64rem;
  --lmlf-ink: #111;
  --lmlf-muted: #555;
  --lmlf-link: #0645ad;
  --lmlf-heading: #d3dce6;
  --lmlf-heading-dark: #bcc4cc;
  --lmlf-rule: #a4abb2;
  --lmlf-lean: #f4f8fc;
  --lmlf-lean-rule: #9bb7d3;
}

body {
  background: #fff;
  color: var(--lmlf-ink);
  font-family: Georgia, "Times New Roman", serif;
}

main { max-width: 74rem; }

h1, h2, h3, h4,
.lmlf-source-link,
.lmlf-dlmf-entry__source,
.lmlf-lean > summary {
  font-family: Arial, Helvetica, sans-serif;
}

h2 {
  background: var(--lmlf-heading-dark);
  border-top: .28rem double var(--lmlf-rule);
  color: #111;
  padding: .38rem .55rem;
}

h3 {
  background: var(--lmlf-heading);
  color: #111;
  padding: .28rem .48rem;
}

h4 { color: #222; }
a { color: var(--lmlf-link); }

.lmlf-source-link {
  border-bottom: 1px solid #c8cdd2;
  margin: .3rem 0 1.35rem;
  padding: 0 0 .6rem;
}

.lmlf-source-link a { font-weight: 700; }

.lmlf-dlmf-entry {
  border-bottom: 1px solid #c8cdd2;
  border-top: 1px solid #c8cdd2;
  margin: 1.2rem 0 1.7rem;
  padding: .75rem 0 .95rem;
}

.lmlf-dlmf-entry__body {
  display: grid;
  gap: .15rem;
}

.lmlf-dlmf-entry__source {
  font-size: .86rem;
  font-weight: 700;
  margin-bottom: .65rem;
}

.lmlf-dlmf-entry__body > :first-child { margin-top: 0; }

.lmlf-lean {
  background: var(--lmlf-lean);
  border: 1px solid var(--lmlf-lean-rule);
  margin: .85rem 0 .15rem;
}

.lmlf-lean > summary {
  color: #174f80;
  cursor: pointer;
  font-size: .86rem;
  font-weight: 700;
  padding: .55rem .7rem;
}

.lmlf-lean[open] > summary { border-bottom: 1px solid var(--lmlf-lean-rule); }
.lmlf-lean__body { padding: .2rem .7rem .65rem; }

/* Blueprint declarations elaborate with `sorry`, but proof status is not part of the
   reader-facing statement. Verso attaches that warning to the theorem name; suppress only
   its popover and warning decoration inside LMLF statement disclosures. */
.lmlf-lean .has-info.warning { text-decoration: none; }
.lmlf-lean .has-info.warning > .hover-container { display: none; }

.lmlf-section-list > ul {
  list-style: none;
  margin-left: 0;
  padding-left: 0;
}

.lmlf-section-list li {
  border-bottom: 1px dotted #b7bcc1;
  padding: .24rem .15rem;
}

.lmlf-section-list li::before {
  color: #5f6770;
  content: "\203A";
  display: inline-block;
  margin-right: .48rem;
}

.lmlf-coverage {
  border-collapse: collapse;
  font-family: Arial, Helvetica, sans-serif;
  margin: 1rem 0 1.4rem;
  width: 100%;
}

.lmlf-coverage th,
.lmlf-coverage td {
  border-bottom: 1px solid #c8cdd2;
  padding: .42rem .55rem;
  text-align: right;
}

.lmlf-coverage th:first-child,
.lmlf-coverage td:first-child { text-align: left; }
.lmlf-coverage thead { background: var(--lmlf-heading); }
"#

private def lmlfJs : String := r#"
document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".lmlf-lean .has-info.warning").forEach(element => {
    const message = element.querySelector(".verso-message.warning");
    if (message?.textContent.trim() === "declaration uses `sorry`") {
      if (element._tippy) element._tippy.destroy();
      element.classList.remove("warning");
      element.querySelector(":scope > .hover-container")?.remove();
    }
  });
});
"#

block_extension LeanDisclosure (label : String) where
  data := .str label
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id data contents => open Verso.Output.Html in do
    let .str label := data
      | reportError s!"Invalid Lean-disclosure data: {data.compress}"
        return .empty
    pure {{
      <details class="lmlf-lean" open>
        <summary>{{label}}</summary>
        <div class="lmlf-lean__body">{{← contents.mapM goB}}</div>
      </details>
    }}
  extraCss := [lmlfCss]
  extraJs := [lmlfJs]

block_extension DLMFEntry (number : String) (sourceUrl : String) where
  data := .arr #[.str number, .str sourceUrl]
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id data contents => open Verso.Output.Html in do
    let .arr #[.str number, .str sourceUrl] := data
      | reportError s!"Invalid DLMF-entry data: {data.compress}"
        return .empty
    let label := s!"DLMF {number} ↗"
    pure {{
      <article class="lmlf-dlmf-entry">
        <div class="lmlf-dlmf-entry__source"><a href={{sourceUrl}}>{{label}}</a></div>
        <div class="lmlf-dlmf-entry__body">{{← contents.mapM goB}}</div>
      </article>
    }}
  extraCss := [lmlfCss]

block_extension DLMFChapter (sourceUrl : String) where
  data := .str sourceUrl
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id data contents => open Verso.Output.Html in do
    let .str sourceUrl := data
      | reportError s!"Invalid DLMF-chapter data: {data.compress}"
        return .empty
    pure {{
      <div class="lmlf-source-link">
        {{← contents.mapM goB}}
        <a href={{sourceUrl}}>"Open this chapter in the DLMF ↗"</a>
      </div>
    }}
  extraCss := [lmlfCss]

block_extension SectionIndex where
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ goB _id _ contents => open Verso.Output.Html in do
    pure {{<nav class="lmlf-section-list">{{← contents.mapM goB}}</nav>}}
  extraCss := [lmlfCss]

block_extension CoverageSummary where
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ _ _id _ _ => open Verso.Output.Html in do
    pure {{
      <table class="lmlf-coverage">
        <thead><tr>
          <th>"Chapter"</th><th>"DLMF formulas"</th><th>"Lean statements"</th>
          <th>"Proved"</th><th>"Quantitative"</th>
        </tr></thead>
        <tbody>
          <tr><td>"4"</td><td>"531"</td><td>"531"</td><td>"0"</td><td>"0"</td></tr>
          <tr><td>"5"</td><td>"169"</td><td>"160"</td><td>"2"</td><td>"3"</td></tr>
          <tr><td>"6"</td><td>"100"</td><td>"100"</td><td>"0"</td><td>"6"</td></tr>
          <tr><td>"7"</td><td>"139"</td><td>"0"</td><td>"0"</td><td>"0"</td></tr>
          <tr><td>"8"</td><td>"241"</td><td>"0"</td><td>"0"</td><td>"0"</td></tr>
          <tr><td>"9"</td><td>"230"</td><td>"0"</td><td>"0"</td><td>"0"</td></tr>
          <tr><td>"10"</td><td>"698"</td><td>"0"</td><td>"0"</td><td>"0"</td></tr>
          <tr><th>"Total"</th><th>"2,108"</th><th>"791"</th><th>"2"</th><th>"9"</th></tr>
        </tbody>
      </table>
    }}
  extraCss := [lmlfCss]

block_extension SourceInventorySummary where
  traverse _ _ _ := pure none
  toTeX := none
  toHtml := some fun _ _ _id _ _ => open Verso.Output.Html in do
    pure {{
      <table class="lmlf-coverage">
        <thead><tr><th>"Source-item kind"</th><th>"Candidates"</th></tr></thead>
        <tbody>
          <tr><td>"Numbered formulas"</td><td>"2,108"</td></tr>
          <tr><td>"Main-flow prose blocks"</td><td>"1,575"</td></tr>
          <tr><td>"Unnumbered display formulas"</td><td>"3"</td></tr>
          <tr><td>"Table rows"</td><td>"221"</td></tr>
          <tr><td>"Figure captions"</td><td>"161"</td></tr>
          <tr><td>"Annotation notes"</td><td>"395"</td></tr>
          <tr><td>"Proof sketches"</td><td>"109"</td></tr>
          <tr><td>"Editorial change notes"</td><td>"220"</td></tr>
          <tr><th>"Total structural candidates"</th><th>"4,792"</th></tr>
        </tbody>
      </table>
    }}
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
def leanStatement : DirectiveExpanderOf OneString
  | { value }, contents => do
    ``(Block.other (LeanDisclosure $(quote value.getString))
      #[$(← contents.mapM elabBlock),*])

@[directive]
def dlmfEntry : DirectiveExpanderOf TwoStrings
  | { first, second }, contents => do
    ``(Block.other (DLMFEntry $(quote first.getString) $(quote second.getString))
      #[$(← contents.mapM elabBlock),*])

@[directive]
def dlmfChapter : DirectiveExpanderOf OneString
  | { value }, contents => do
    ``(Block.other (DLMFChapter $(quote value.getString))
      #[$(← contents.mapM elabBlock),*])

@[directive]
def sectionIndex : DirectiveExpanderOf Unit
  | (), contents => do
    ``(Block.other SectionIndex #[$(← contents.mapM elabBlock),*])

@[directive]
def coverageSummary : DirectiveExpanderOf Unit
  | (), contents => do
    if !contents.isEmpty then
      throwError "The coverageSummary directive takes no content"
    ``(Block.other CoverageSummary #[])

@[directive]
def sourceInventorySummary : DirectiveExpanderOf Unit
  | (), contents => do
    if !contents.isEmpty then
      throwError "The sourceInventorySummary directive takes no content"
    ``(Block.other SourceInventorySummary #[])

end LMLFManual
