# AI Configuration

[Русский](README_RU.md)

Versioned global configuration for AI coding agents — Claude Code and Gemini CLI. The files in this repository are the single source of truth; they are applied to the system via symlinks into `~/.claude` and `~/.gemini`, so every edit here takes effect immediately and stays under version control.

## Repository layout

| Path | Purpose |
|------|---------|
| `CLAUDE.md` | Global agent standards for Claude Code (linked to `~/.claude/CLAUDE.md`) |
| `GEMINI.md` | Same standards for Gemini CLI, plus a Gemini-specific memories section (linked to `~/.gemini/GEMINI.md`) |
| `claude_conf/settings.json` | Claude Code user settings: permissions, sandbox, plugins, skill overrides (linked to `~/.claude/settings.json`) |
| `gemini_conf/settings.json` | Gemini CLI user settings (linked to `~/.gemini/settings.json`) |
| `create_links.sh` | Creates all the symlinks above and links skills from `~/.agents/skills` into `~/.claude/skills` |

The core sections of `CLAUDE.md` and `GEMINI.md` are intentionally identical; only the "Gemini Added Memories" section at the end of `GEMINI.md` differs.

Agent skills live in a **separate repository** at `~/.agents` (its `skills/` directory is symlinked into `~/.claude/skills` by the script).

## Setup on a new machine

```sh
git clone <this-repo> ~/.ai
git clone <agents-repo> ~/.agents   # skills library; optional but recommended
cd ~/.ai && ./create_links.sh
```

The script is idempotent — safe to re-run at any time (e.g. after adding a new skill to `~/.agents/skills`). If `~/.agents` is missing it prints a warning and skips the skills step.

## Usage rules

### 1. Keep the policy files in sync

`CLAUDE.md` and `GEMINI.md` must be edited **together**. When adding a rule, put the same wording into the same section of both files:

```sh
# after editing both files, verify the core sections still match:
diff -B <(sed '/## Gemini Added Memories/,$d' GEMINI.md) CLAUDE.md
```

Only the "Gemini Added Memories" section may diverge.

### 2. Commit promptly — this repo is the backup

A dirty working tree means unprotected configuration. After any change:

```sh
git -C ~/.ai add -A && git -C ~/.ai commit -m "Describe the change"
```

Check occasionally with `git -C ~/.ai status --short`.

### 3. Edit the repo files, not copies

Thanks to the symlinks, editing `~/.claude/settings.json` or `~/.ai/claude_conf/settings.json` is the same file. If a tool ever replaces the symlink with a plain file, changes stop reaching the repo — verify with:

```sh
ls -la ~/.claude/settings.json   # must show -> /Users/<you>/.ai/claude_conf/settings.json
```

Re-run `./create_links.sh` to repair broken links.

### 4. Scope plugins per project, keep global minimal

Every globally enabled plugin loads its tools and skills into **every** session in every repo. Keep only universally useful plugins in `claude_conf/settings.json`; enable heavy, domain-specific ones in the project that needs them:

```json
// <project>/.claude/settings.json — this project does design work
{ "enabledPlugins": { "figma@claude-plugins-official": true } }
```

```json
// <project>/.claude/settings.local.json — personal opt-out in one project
{ "enabledPlugins": { "playwright@claude-plugins-official": false } }
```

Precedence: user < project < local — so a project can enable what the user config disables, and local can override both.

### 5. Keep global instructions small and actionable

Global `CLAUDE.md`/`GEMINI.md` are injected into every session's context. Keep them to rules the agent can actually follow anywhere (approval workflow, TDD, commit hygiene). Domain standards belong in the project:

- Global: "never commit without approval", "no AI attribution in commits"
- Project `CLAUDE.md`: REST conventions, error-response JSON shape, migration policy, "use `make test`"

### 6. Curate Gemini memories

`save_memory` is only for cross-project user facts and preferences. Project-specific notes go into that project's `GEMINI.md`. Periodically re-read the "Gemini Added Memories" section and delete duplicates, stale entries, and contradictions — it grows append-only otherwise.

### 7. Manage skills through `~/.agents`

Add or edit skills in `~/.agents/skills/<name>/`, commit there, then re-run `./create_links.sh` to link new ones. Hide skills you invoke manually but the model shouldn't auto-trigger, keeping their `/name` available:

```json
// claude_conf/settings.json
{ "skillOverrides": { "grill-me": "user-invocable-only" } }
```

### 8. Permissions hygiene

Deny globs should cover any depth, not just the project root — `Read(**/.env)`, not `Read(./.env)`. When a safe read-only tool keeps prompting for permission, add it to `permissions.allow` here (versioned) rather than clicking "always allow" into an unversioned local file.
