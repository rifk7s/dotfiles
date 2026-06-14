---
name: feedback-ctx7-bunx
description: "User runs ctx7 via bunx, not npx. Use `bunx ctx7@latest …` for context7 documentation lookups."
metadata: 
  node_type: memory
  type: feedback
---

User uses bun as package manager — invoke `ctx7` (context7 CLI) via `bunx ctx7@latest …` instead of `npx ctx7@latest …`. Applies to both `library` and `docs` subcommands.

**Why:** User explicitly corrected this on 2026-05-21 while planning the smart-reminder-lite branch. The FE package also uses bun/bunx ([[project-fe-package-manager]]), so this is consistent across the repo.

**How to apply:** Whenever invoking context7 CLI (or any tool wrapper documented with npx), substitute `bunx` for `npx`. Same for one-shot npm packages in scripts/snippets shown to the user.
