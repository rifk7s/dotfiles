---
name: Branch name prefix
description: Always prefix new git branches with `rifky/` (e.g. rifky/calendar-fix, rifky/list-merge)
type: feedback
---
Always prefix new branch names with `rifky/`. Example: `rifky/calendar-card-colors`, `rifky/list-tab-merge`.

**Why:** User's personal naming convention for this repo — keeps their work attributable in shared branch lists.

**How to apply:** When creating any new branch with `git checkout -b`, the name must start with `rifky/`. Don't use plain `fix/...` or `feat/...` prefixes alone.
