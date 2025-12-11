Global configuration and standards for Claude-assisted development workflows.

Purpose

This global CLAUDE.md defines organization-wide defaults, standards, and tool preferences for projects that integrate Claude as a development or automation assistant.
Place this file at ~/.claude/CLAUDE.md to apply guidance globally across repositories.

Scope

Applies to all projects, environments, and automation pipelines that use Claude for development, code review, documentation, or deployment tasks.

Core Standards
1. Approval Workflow

Never stage, commit, or deploy changes without explicit human approval.

Claude must present a diff or summary for review before any action that modifies code or infrastructure.

2. Test-Driven Development (TDD)

Adopt a strict TDD cycle:

Write failing tests.

Implement minimal code to pass them.

Refactor.

Prioritize small, isolated unit tests and fast integration tests.

Work on atomic features only — one self-contained piece of functionality at a time.

After completion, Claude should generate a test and integration summary and wait for review before proceeding.

3. Error Handling

Fail fast and surface actionable errors.

Avoid swallowing exceptions or returning ambiguous results.

Use structured error responses for APIs, following this format:

{
  "code": "ERR_CODE",
  "message": "Readable explanation",
  "details": {},
  "trace_id": "00000000-0000-0000-0000-000000000000"
}


code: machine-readable identifier

message: human-readable context

details: optional structured metadata

trace_id: UUID for tracing/log correlation

Log all errors with their trace IDs, limiting sensitive context for privacy and compliance.

4. REST API Practices

Use standard HTTP methods (GET, POST, PUT, PATCH, DELETE) with semantic intent.

Maintain resource-oriented endpoints and consistent status codes.

Implement pagination for list results.

Always version APIs and include deprecation guidance in documentation.

5. CI / Testing Enforcement

CI must block merges on failing tests.

PRs without tests for new functionality should be flagged.

Define separate preflight (fast) and full (comprehensive) test suites:

Preflight: Unit + lint checks (required for PR gating)

Full: Integration + E2E (required before merging to protected branches)

Encourage incremental commits with verified test coverage; use coverage metrics as guidance, not strict blockers.

6. Secrets & Deployment

Never commit or embed secrets.

Store credentials in approved secret managers (Vault, AWS Secrets Manager, etc.).

Require explicit approvals for production deploys and maintain rollback procedures.

Database migrations must follow: staging → canary → production rollout, with backups and validated rollback paths.

Tooling & Preferences
1. Documentation Retrieval

Prefer web_fetch (or Claude’s internal doc fetcher) for retrieving authoritative references (RFCs, SDK docs, API specs).

Include source URL and fetch timestamp in any retrieved documentation.

If unavailable, fallback to verified cached or explicitly cited sources.

2. Git & Shell Automation

Use explicit, documented shell commands for Git operations (commit, rebase, merge).

Interactive or destructive operations must remain human-approved.

3. Auto-Accept Rules

Safe operations may be auto-accepted:

Code formatting (Prettier, Black)

Lint fixes

Non-destructive “chore” commits (e.g., comments, whitespace)

Patch-level dependency updates that pass CI

Dangerous or irreversible actions — such as schema drops, data deletions, or secret rotations — require manual approval.

Every auto-accept event must be logged with user, timestamp, and source, and should be reversible when feasible.

Recommended Conventions
Category	Convention
Branch naming	feature/<short-desc>, fix/<issue-id>, chore/<scope>
Commit messages	Short (≤72 chars) subject, optional descriptive body, reference issue IDs
Versioning	Follow Semantic Versioning for public packages
Notes

This file serves as a global policy for Claude-assisted workflows.

Local CLAUDE.md files within repositories may extend or override specific rules.

Review and update this document periodically to align with evolving best practices and Claude API capabilities.
