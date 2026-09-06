import VersoManual
import LMLFManual

open Verso Doc
open Verso.Genre Manual

def config : RenderConfig where
  emitTeX := false
  emitHtmlSingle := .no
  emitHtmlMulti := .immediately
  htmlDepth := 2
  extraFilesHtml := [("../coverage", "coverage")]

def main := manualMain (%doc LMLFManual) (config := config)
