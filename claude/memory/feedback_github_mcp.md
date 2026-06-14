---
name: Prefer gh CLI, fall back to GitHub MCP
description: User has gh CLI installed; use it for PR creation/edits and other GitHub ops, falling back to GitHub MCP only when gh lacks the command
type: feedback
---
Use the `gh` CLI via Bash for GitHub operations (PR create/edit, issues, reviews, etc.). **Never load `mcp__github__*` tools for operations that `gh` supports** — doing so wastes tokens loading schemas unnecessarily.

**Why:** User prefers `gh` CLI and has explicitly called out wasting MCP tokens on operations like `gh pr edit` that are trivially available in `gh`. Repeated mistake across sessions — user was very angry about this.

**How to apply:** Before reaching for any `mcp__github__*` tool, ask: can `gh` do this? For PR create/edit/view, issues, comments — yes. Only fall back to MCP if `gh` genuinely lacks the command.
