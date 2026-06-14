# Memory Index

- [Use git add . when staging](feedback_git_add.md) — always `git add .`, not selective file staging
- [PR description style](feedback_pr_description_style.md) — `- [+]` bullets, specific file/component names, one closing summary sentence, no headers
- [No plan codes in commits/PRs](feedback_no_plan_codes_in_commits.md) — never reference internal plan codes (C1, M5, F1…) in commits/PRs; describe the behavior instead
- [No em dashes in titles](feedback_no_em_dashes.md) — never use `—` in PR titles or commit subjects; use `:`, `,`, `and`, or `+` instead
- [No Claude footer](feedback_no_claude_footer.md) — NEVER add "Generated with Claude Code" footer to PRs/commits (embarrassing on shared repo)
- [Prefer gh CLI, fall back to GitHub MCP](feedback_github_mcp.md) — use `gh` for PRs/issues; fall back to `mcp__github__*` only if gh lacks the command
- [Branch name prefix](feedback_branch_prefix.md) — always prefix new branches with `rifky/`
- [Heavy native tasks workflow](feedback_heavy_native_tasks.md) — user runs slow native builds manually, Claude verifies after
- [ctx7 via bunx](feedback_ctx7_bunx.md) — invoke context7 CLI as `bunx ctx7@latest …`, never `npx`
- [Commit format](feedback_commit_format.md) — never push to main, use conventional commits (type(scope)) and `[-]` bullet body
