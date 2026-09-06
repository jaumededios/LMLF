# LMLF Verso overlay

This nested Lake project builds the read-only LMLF documentation overlay.
It does not change the semantic library's dependency graph.

```sh
cd doc
lake update
lake build
lake exe lmlf-site
python3 -m http.server 8000 -d _out/html-multi
```

Open `http://localhost:8000` after generation. The source navigation is a
versioned DLMF cross-reference; the displayed LMLF status remains authoritative
only to the extent that it is backed by the repository's cards and declarations.
