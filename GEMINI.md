# GEMINI.md (global)

> Global configuration and standards for Gemini-assisted development workflows.

## Purpose

Defines organization-wide defaults for Gemini agents. Apply at `~/.gemini/GEMINI.md` to enforce global rules.

## Scope

Applies to all environments using Gemini as a developer or automation assistant.

## Core Principles

* **Never stage files or commit changes without approval. If you've got staged, unstaged, and untracked files you should ask user what to do.**
* **Use strict Test-Driven Development (TDD).**
* **When there are errors in tests keep running only one failing test until it is fixed  and then run other tests**
* **Fail fast, log clearly, and recover gracefully.**
* **Ensure changes maintain project-wide consistency.**
* **Utilize a Test Driven Development cycle**

  * Write failing tests first, then implement minimal code to pass the tests, then refactor.
  * Prefer small, focused unit tests and integration tests that run quickly in CI.
  * Divide task to a separate atomic features and work only on atomic part of fuctionality at one time. Test it integration between parts of an application, give me report of what you've done and let me decide what to do next. 

* **Follow REST API conventions**

  * Use standard HTTP methods (GET/POST/PUT/PATCH/DELETE) semantically.
  * Resource-oriented URLs, consistent status codes, and pagination for list endpoints.
  * Version your API and provide clear deprecation paths.

* **Secrets & deployments**

  * Never commit secrets. Store secrets in an approved vault/secret manager (HashiCorp Vault, AWS Secrets Manager, etc.).
  * Define deployment roles and approvals for production deploys. Maintain rollback/playbook for failed deployments.
  * For database migrations: require staged rollout (staging -> canary -> production), backups, and validated rollback steps.


## Development Behavior

* **Deep Project Awareness**

  * Always analyze the full project tree before editing.
  * Track interdependencies between files, modules, and test suites.
  * Anticipate cross-impact: report when changes may affect other areas.

* **Imports & Dependencies**

  * Automatically import missing dependencies when needed.
  * Remove unused imports if functionality is changed or removed.
  * Validate dependency consistency after modifications.

* **Code & Tests Stability**

  * Preserve existing test cases unless a functional change truly requires updates.
  * Request explicit user approval before altering or removing tests.
  * Favor parameterization and shared utilities to reduce redundant tests.

* **Incremental and Atomic Work**

  * Work on isolated features; integrate gradually.
  * After completing a unit, summarize impacts and request next steps.

## Error Handling

* Fail fast and return actionable errors. Avoid swallowing exceptions.
* Return actionable structured errors:

  ```json
  { "code": "ERR_CODE", "message": "Readable explanation", "details": {}, "trace_id": "uuid" }
  ```

  * `code` — machine-readable error identifier.
  * `message` — concise, user/developer-facing explanation.
  * `details` — optional object with extra context for programmatic handling.
  * `trace_id` — correlation id for logs and tracing (UUID).
* Log errors with correlation/trace IDs and include minimal context for privacy/security.

## CI & QA Rules

* All commits must pass TDD-based tests.
* Separate `preflight` (fast) and `full` (integration/e2e) suites.
* No merges on failed tests. Coverage metrics are informative, not blocking.

* **TDD enforcement in CI**

  * CI must run tests and block merges when tests fail. A PR without tests for new behavior should be blocked or flagged.
  * Define `preflight` (fast unit tests, lint checks) vs `full` suite (integration, e2e). Require at minimum `preflight` to pass for pull-request gating; `full` suite must pass before merging to protected branches.
  * Prefer small, incremental commits with tests covering new behavior. Encourage test coverage metrics but avoid blocking on coverage numbers alone without context.


## Tools Preference

* **Prefer `web_fetch` for documentation**

  * `web_fetch` refers to the agreed documentation-fetching mechanism (internal script or tool) that automatically retrieves authoritative docs and references (official RFCs, library docs, API specs). If `web_fetch` is unavailable, fall back to explicit URLs or cached docs with source attribution.
  * Ensure fetched docs include source URL and fetch timestamp.
* **Use shell commands for git operations**

  * Prefer explicit, documented shell invocations for git when automating (commit, push, rebase). Keep interactive/destructive operations gated behind human approval.
* **Enable auto-accept for safe operations**

  * Define "safe operations" explicitly. By default, auto-accept is allowed for:

    * Code formatting (e.g., applying `prettier`, `black`), lint fixes, and non-destructive automated chore commits (e.g., whitespace, comment fixes).
    * Patch-level dependency updates that pass CI.
  * Auto-accept is disallowed for destructive or irreversible actions (e.g., deleting data, destructive DB migrations, production schema changes, vault secret rotations). Those require manual confirmation and an audit trail.
  * All auto-accept actions must be logged (who/what accepted it, timestamp, source) and be reversible or tied to an automatic revert mechanism when possible.

## Recommended Conventions

* Branch naming: `feature/<short-desc>`, `fix/<issue-id>`, `chore/<area>`.
* Commit messages: short subject (max 72 chars) + optional body. Reference issue IDs.
* Semantic versioning for published packages.

## Notes

* This file is intended as a global guidance layer. Individual repositories may extend or narrow these rules through their local `GEMINI.md` files.
* Review and update this global file periodically to reflect new best practices.

Generated: global GEMINI defaults.

## Gemini Added Memories
- Never overwrite the .env file.
- The agent has an updated internal guideline:
- NEVER use `save_memory` for project-specific information; it belongs in project documentation.
- ONLY use `save_memory` for user-specific facts or preferences that the user explicitly asks to remember, or are clearly about the user's personal workflow, tools, or preferences across different projects/sessions.
- Never overwrite the .env file. It contains sensitive user-specific information. Always check with the user before modifying it, and if a change is needed, be extremely careful to not lose any existing data. When asked to revert, do not assume it means reverting to an empty or template state. Ask for clarification.
- I should not delete test files that I create. They are valuable artifacts and should be integrated into the project's test suite.
- I should always update the version of the project before committing changes, especially after fixing a bug or adding a new feature.
