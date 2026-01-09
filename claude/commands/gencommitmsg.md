---
description: Generate a conventional commit message from staged changes
---

Analyze the staged changes and generate a conventional commit message.

## Format

Use this structure:
```
<type>(<scope>): <short description>

- <filename>:
  - <change description>
  - <change description>
- <filename>:
  - <change description>
```

## Rules

1. **Type** must be one of: feat, fix, docs, style, refactor, perf, test, build, ci, chore
2. **Scope** should be the primary area affected (e.g., auth, api, ui, config)
3. **Short description** should be imperative mood, lowercase, no period
4. **File changes** should be grouped by file with indented bullet points for multiple changes
5. Keep descriptions concise but informative

## Steps

1. Run `git diff --cached` to see staged changes
2. Run `git diff --cached --name-only` to list affected files
3. Analyze the changes and determine the appropriate type and scope
4. Generate the commit message following the format above
5. Commit with the generated message using `git commit -m`

Automatically commit after generating the message. Do not ask for confirmation.
