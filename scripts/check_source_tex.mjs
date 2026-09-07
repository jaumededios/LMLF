#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { createRequire } from "node:module";

const repoRoot = path.resolve(import.meta.dirname, "..");
const katexPath = path.join(
  repoRoot,
  "doc",
  "_out",
  "html-multi",
  "-verso-data",
  "katex",
  "katex.js",
);
const require = createRequire(import.meta.url);
const katex = require(katexPath);
const requested = process.argv.slice(2);
const roots = requested.length > 0
  ? requested.map((entry) => path.resolve(entry))
  : [path.join(repoRoot, "doc", "LMLFManual")];

function leanFiles(entry) {
  const stat = fs.statSync(entry);
  if (stat.isFile()) {
    return entry.endsWith(".lean") ? [entry] : [];
  }
  const files = [];
  for (const child of fs.readdirSync(entry, { withFileTypes: true })) {
    const childPath = path.join(entry, child.name);
    if (child.isDirectory()) {
      files.push(...leanFiles(childPath));
    } else if (child.isFile() && child.name.endsWith(".lean")) {
      files.push(childPath);
    }
  }
  return files;
}

function lineNumber(source, offset) {
  return source.slice(0, offset).split("\n").length;
}

const failures = [];
let checked = 0;

for (const file of roots.flatMap(leanFiles)) {
  const source = fs.readFileSync(file, "utf8");
  const expressions = [
    ...Array.from(source.matchAll(/\$\$`([\s\S]*?)`/g), (match) => ({
      displayMode: true,
      match,
    })),
    ...Array.from(source.matchAll(/(?<!\$)\$`([^`]*)`/g), (match) => ({
      displayMode: false,
      match,
    })),
  ];

  for (const { displayMode, match } of expressions) {
    const tex = match[1].trim();
    checked += 1;
    try {
      katex.renderToString(tex, {
        displayMode,
        strict: "ignore",
        throwOnError: true,
      });
    } catch (error) {
      failures.push({
        file: path.relative(repoRoot, file),
        line: lineNumber(source, match.index),
        tex,
        error: error instanceof Error ? error.message : String(error),
      });
    }
  }
}

if (checked === 0) {
  console.error("No Verso TeX expressions found in the requested Lean sources.");
  process.exit(1);
}

if (failures.length > 0) {
  console.error(`KaTeX rejected ${failures.length} of ${checked} source expressions:`);
  for (const failure of failures) {
    console.error(
      `\n${failure.file}:${failure.line}\n  ${failure.tex}\n  ${failure.error}`,
    );
  }
  process.exit(1);
}

console.log(`KaTeX accepted all ${checked} source expressions.`);
