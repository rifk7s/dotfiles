---
name: heavy-native-tasks
description: User runs slow/CPU-heavy native build tasks manually; Claude verifies after
metadata: 
  node_type: memory
  type: feedback
---

For CPU-heavy / long-running native tasks (e.g. `expo prebuild`, `expo run:ios`,
`expo run:android`, native builds), do NOT run them via Claude.

**Why:** They take a long time and burn CPU; waiting on them inside the session also burns
tokens. User has done these before and prefers to drive them.

**How to apply:** Claude does the light/fast config edits (deps install, app.json, code), then
hands off. User runs the heavy commands locally and reports back. Claude then verifies the
result (inspect generated folders, git diff, config) and continues (branch/commit/PR). Split the
plan explicitly into "Claude does" vs "User does (manual)" vs "Claude verifies".
