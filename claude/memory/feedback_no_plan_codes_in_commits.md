---
name: feedback_no_plan_codes_in_commits
description: "never put internal plan/review codes (C1, M5, F1, FE1…) in commit messages or PR descriptions"
metadata: 
  node_type: memory
  type: feedback
---

Never reference internal plan/review codes like `C1`, `M5`, `H1`, `F1`, `FE1` in commit messages or PR descriptions. Those identifiers only exist in the local `~/.claude/plans/*` files, which are NOT committed or referenced in the repo, so they're meaningless and confusing to anyone reading GitHub.

**Why:** the user reviews commits/PRs on GitHub where the plan isn't available; codes look like noise.

**How to apply:** write each commit/PR bullet as a self-contained, plain-language statement of what changed and why. If a fix maps to a plan item, describe the behavior (e.g. "remove the global task-completion update that could complete other users' tasks"), not the code. See [[feedback_pr_description_style]].
