#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";

const siteRoot = path.resolve(process.argv[2] ?? "doc/_out/html-multi");
const katexPath = path.join(siteRoot, "-verso-data", "katex", "katex.js");
const require = createRequire(import.meta.url);
const katex = require(katexPath);

function htmlFiles(directory) {
  const files = [];
  for (const entry of fs.readdirSync(directory, { withFileTypes: true })) {
    const fullPath = path.join(directory, entry.name);
    if (entry.isDirectory()) {
      files.push(...htmlFiles(fullPath));
    } else if (entry.isFile() && entry.name.endsWith(".html")) {
      files.push(fullPath);
    }
  }
  return files;
}

function decodeHtml(text) {
  return text
    .replace(/&#(\d+);/g, (_, digits) => String.fromCodePoint(Number(digits)))
    .replace(/&#x([0-9a-f]+);/gi, (_, digits) => String.fromCodePoint(parseInt(digits, 16)))
    .replaceAll("&lt;", "<")
    .replaceAll("&gt;", ">")
    .replaceAll("&quot;", '"')
    .replaceAll("&#39;", "'")
    .replaceAll("&amp;", "&");
}

const mathPattern = /<code class="math (inline|display)">([\s\S]*?)<\/code>/g;
const failures = [];
let checked = 0;

for (const file of htmlFiles(siteRoot)) {
  const html = fs.readFileSync(file, "utf8");
  for (const match of html.matchAll(mathPattern)) {
    const mode = match[1];
    const tex = decodeHtml(match[2].replace(/<[^>]*>/g, "")).trim();
    checked += 1;
    try {
      katex.renderToString(tex, {
        displayMode: mode === "display",
        strict: "ignore",
        throwOnError: true,
      });
    } catch (error) {
      failures.push({
        file: path.relative(siteRoot, file),
        tex,
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }
}

if (checked === 0) {
  console.error(`No generated TeX expressions found under ${siteRoot}`);
  process.exit(1);
}

if (failures.length > 0) {
  console.error(`KaTeX rejected ${failures.length} of ${checked} generated expressions:`);
  for (const failure of failures) {
    console.error(`\n${failure.file}\n  ${failure.tex}\n  ${failure.error}`);
  }
  process.exit(1);
}

console.log(`KaTeX accepted all ${checked} generated expressions.`);
