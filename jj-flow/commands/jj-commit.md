---
description: Commit current changes using jj
effort: low
---

Commit these changes using `jj commit -m "Commit message"`

Current changes: !`jj diff --git`

Example recent commit messages: !`jj log -r 'all()' -T 'description ++ "\n"' --no-graph --limit 10`

For more info run `jj commit --help`
