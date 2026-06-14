---
name: feedback-no-em-dashes
description: Never use em dashes anywhere in PR titles, commit subjects, or PR/commit bodies; user dislikes them
metadata:
  node_type: memory
  type: feedback
---

Do not use em dashes anywhere in PR titles, commit subjects, or PR/commit bodies. Use a colon, a comma, parentheses, "and", "+", or rephrase as a plain sentence instead. This also applies to MEMORY.md index hooks.

**Why:** User flagged em dashes on PR #73 title, then again on the body after I left one in ("net -438 lines BE"). Stylistic preference, applies everywhere user-visible in git/GitHub artifacts.

**How to apply:** Before writing any PR title, PR body, commit subject, or commit body, scan for the em-dash character and rewrite. Arrows and regular hyphens are fine.
