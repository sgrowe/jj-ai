---
description: Update plugin version number
argument-hint: <optional version number>
---

Update the plugin version numbers in `.claude-plugin/marketplace.json`. If `$ARGUMENTS` is provided use that as the version number, otherwise just increment the patch version. Then commit that change using `jj commit -m "Release version X.Y.Z"`
