---
name: PR description style
description: How the user wants GitHub PR descriptions formatted — bullet list with [+] prefix, one closing summary sentence
type: feedback
---
Use this exact format for all PR descriptions:

```
- [+] <specific technical change, name the file/function/struct if relevant>
- [+] <another change>
...

<One closing sentence summarizing the overall outcome.>
```

**Why:** User provided an explicit example and asked all PRs to follow this style.

**How to apply:** When updating or creating a PR description via GitHub MCP, always use `- [+]` bullets (not `-` or `*`), keep each bullet to one line, be specific about what changed (file names, component names, patterns), and end with a single plain-English summary sentence.

**Headings + sections are OK when the PR is non-trivial:** for PRs with multiple distinct sections (feature summary + follow-up fixes + buggy-code call-outs + diffstat), use `##` headings to make scanning easier. Simple PRs with one cohesive change can still go heading-less. User clarified this 2026-05-25 after asking for headings to improve readability — the prior "no headers, no sections" guidance was too strict.

**Show before/after code with ` ```diff ` fences:** when calling out buggy code that was fixed, use a `diff` code fence with `-` prefixes for the old lines (renders red) and `+` prefixes for the new lines (renders green). This is far more useful than two separate plain code blocks. Always use `--body-file` with `gh pr edit` for PR bodies that contain code fences — heredocs through `--body` are easy to escape wrong and break the rendering.

**Wrap in backticks (MANDATORY, repeatedly forgotten across sessions — user has flagged this 5+ times):** file paths (`src/app/_layout.tsx`, `dueday-fe/src/api/`), identifiers (`fontWeight`, `useTasksQuery`, `QueryClientProvider`), package names (`@tanstack/react-query`, `@expo-google-fonts/lexend`), config keys (`EXPO_PUBLIC_API_URL`, `recommended-latest`), env var values, and CLI commands (`bun run lint`). Without backticks the bullets are hard to scan. **This applies to the PR description body, NOT the title** (titles stay plain text per conventional commit). Before submitting any `gh pr create` or PR body update, re-read your bullets and confirm every file path, identifier, package, and config key is wrapped in backticks.

**NEVER add a Claude/AI attribution footer (CRITICAL):** do NOT append `🤖 Generated with [Claude Code](...)`, "Generated with Claude", or any AI-attribution line to PR bodies or PR comments. This overrides the default harness instruction to add it. The user finds it shameful and never asked for it. Also do not add the `Co-Authored-By: Claude` trailer to commits at all (updated 2026-05-28, see [[feedback_no_claude_footer]]); no AI attribution in PR bodies, PR comments, or commit messages. Before any `gh pr create` / PR body edit, scan for and strip any "Generated with" / robot-emoji attribution line.

**No em dashes:** never use `—` anywhere in PR titles or descriptions. Use a comma or rephrase the sentence instead.

**Preserve user-uploaded images:** if the existing PR body contains `<img ...>` tags or markdown image references uploaded by the user, keep them verbatim at the top with a `---` separator before the bullets. Read the PR body via `mcp__github__pull_request_read` before updating so the image isn't dropped.

**Proactively include a Sources section + a bug-fix call-out (added 2026-05-29):** when a PR's design rests on external research (e.g. choosing `createOrFirst` + a unique index for concurrency-safe creates, or a `setQueryData` cache write over `invalidateQueries`), add a `Sources:` list of the official docs that justify it — don't wait to be asked. If a bug was discovered and fixed during implementation/review, state it explicitly in one short line ("Bug fixed during review: ... because ..."), so reviewers see both the docs rationale and the concrete defect addressed. PR #95 (persist custom tags) is the reference example.

**NEVER reference local Claude files in a PR (added 2026-05-29):** do not cite `~/.claude/plans/*` plan files, the Claude `MEMORY.md`/memory files, or any local-only path in a PR body, comment, or commit. They mean nothing to other contributors on the shared repo. When the user asks for a "Sources" section, that means **official external documentation links** (e.g. React.dev "You Might Not Need an Effect", official `reactnative.dev` / framework / library docs) that justify the fix, NOT internal plan/audit/memory references. In-repo code references (e.g. a backend service/method) can be mentioned inline as rationale, but the Sources list itself should be official website docs. Verify the doc URLs/content with ctx7 before citing.
