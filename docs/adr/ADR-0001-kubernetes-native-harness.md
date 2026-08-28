# ADR-0001: Kiro-native, Git-backed AI Harness

- **Status:** Accepted
- **Date:** 2026-08-28
- **Decision owners:** Initial repository governance

## Context

Enterprise messaging work requires repeatable requirements, design, implementation, validation, review, and release controls. Long prompts and unstructured Agent-to-Agent conversations lose context, are difficult to audit, and cannot prove human approval. External gstack/Superpowers packages are not installed or version-selected for this workspace.

## Decision

Use Kiro workspace Agent profiles, Skills, Steering, and tracked Markdown workflows. Git is the durable SSOT. Agents exchange six versioned document contracts under `docs/work-items/<work-id>/`. Require Human Gates for requirement, plan, PR merge, and production release. Configure Agents without inherited MCP/Powers, and prohibit production access/deployment.

Represent the useful gstack/Superpowers concepts—specialized roles, progressive procedures, independent review, evidence, and stop conditions—as native repository assets rather than an undeclared runtime dependency.

## Consequences

- Work is auditable, reviewable, portable, and reproducible from the repository.
- Teams must maintain rules/templates and record approvals; initial process overhead increases.
- Markdown validation proves structure, not organizational authorization or application correctness.
- Product-specific CI/CD, schemas, branch protection, and environment controls must be integrated by the adopting repository.

## Alternatives rejected

- Prompt-only workflow: weak reproducibility and knowledge retention.
- Free-form multi-agent conversation: weak contract, audit, and approval semantics.
- Fully autonomous production deployment: violates security and accountability boundaries.
- Unpinned external harness packages: unclear provenance, version, and operating contract.
