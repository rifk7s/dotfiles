---
name: Commit format
description: Git workflow rules — Branch protection, PR requirement, and conventional commit formatting
type: feedback
---
## Git

**Branch protection is on. Never push directly to `main`.** Always work on a feature branch and open a PR.

Commit format: `type(scope): short description`
- Types: `feat`, `fix`, `chore`, `refactor`, `docs`, `bench`
- Scope is optional but encouraged (e.g. `feat(calendar): ...`, `chore(deps): ...`)
- Body: one `- [+] description` bullet per logical change

Example:
```
feat(calendar): add due date grouping

- [+] Group tasks by due date in calendar view
- [+] Add sticky section headers with date labels
- [+] Handle empty state per date group
```
