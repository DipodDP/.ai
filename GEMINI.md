# GEMINI.md (global)

> Global configuration and standards for Gemini-assisted development workflows.

## Purpose

This global GEMINI.md provides organization-wide defaults, standards, and tool preferences that Gemini agents and contributors should follow when working across repositories. Place this file at `~/.gemini/GEMINI.md` to apply global guidance.

## Scope

Applies to: all projects and environments where Gemini is used as a developer assistant or automation agent.

## Standards

* **Utilize a Test Driven Development cycle**

  * Write failing tests first, then implement minimal code to pass the tests, then refactor.
  * Prefer small, focused unit tests and integration tests that run quickly in CI.
* **Implement proper error handling**

  * Fail fast and return actionable errors. Avoid swallowing exceptions.
  * Provide structured error responses for APIs (error code, message, metadata).
  * Log with sufficient context and correlation IDs to diagnose production issues.
* **Follow REST API conventions**

  * Use standard HTTP methods (GET/POST/PUT/PATCH/DELETE) semantically.
  * Resource-oriented URLs, consistent status codes, and pagination for list endpoints.
  * Version your API and provide clear deprecation paths.
* **Continuous Integration & Testing**

  * Every PR must run the full test suite on CI before merging.
  * Fast feedback loops: run unit tests on pre-commit or lightweight CI checks.
* **Code Quality & Style**

  * Use linters and formatters (project-specific) configured in the repo.
  * Prefer clear, readable code and small, focused commits.
* **Security & Secrets**

  * Never commit secrets. Use vaults / secret managers and environment-based secrets.
* **Documentation**

  * Keep README and API docs up-to-date. Document expected inputs, outputs, and error responses.
* **Observability**

  * Add metrics and structured logs for critical flows. Instrument long-running jobs.

## Tools Preference

* **Prefer `web_fetch` for documentation**

  * Use `web_fetch` (or an agreed documentation fetcher) to gather authoritative docs and references automatically where possible.
* **Use shell commands for git operations**

  * Prefer predictable shell invocation for git (commit, push, rebase) when automation is required. Keep git flows simple and well-documented.
* **Enable auto-accept for safe operations**

  * Automatically accept non-destructive, reversible operations (e.g. file formatting, lint fixes) when confidence is high.
  * Require manual confirmation for destructive or irreversible actions (deleting data, migrating production).

## Recommended Conventions

* Branch naming: `feature/<short-desc>`, `fix/<issue-id>`, `chore/<area>`.
* Commit messages: short subject (max 72 chars) + optional body. Reference issue IDs.
* Semantic versioning for published packages.

## Example: Minimal CI job (pseudo)

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup
        run: |
          # prepare environment
      - name: Run tests
        run: |
          pytest -q
```

## Notes

* This file is intended as a global guidance layer. Individual repositories may extend or narrow these rules through their local `GEMINI.md` files.
* Review and update this global file periodically to reflect new best practices.

---

Generated: global GEMINI defaults.

