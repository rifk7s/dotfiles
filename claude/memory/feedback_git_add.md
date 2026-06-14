---
name: Use git add . when staging
description: Always use git add . instead of selectively staging files
type: feedback
originSessionId: ff648a31-2d99-4146-8ab0-dca2d7ef4b26
---
Use `git add .` when staging commits — don't cherry-pick files unless there's a clear reason to exclude something.

**Why:** Selective staging caused a committed dependency update (composer.lock) to be missed.

**How to apply:** Default to `git add .` for all commits in this monorepo. Only stage specific files if the user explicitly asks to exclude something.
