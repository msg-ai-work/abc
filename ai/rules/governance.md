# Governance and Ownership Rules

## Operating model

- **Policy Authority (U+)** owns mandatory architecture, security, compliance, data, API/event, quality, and release criteria.
- **Domain Execution (MediaLog)** converts approved policy and requirements into reusable code, tests, runbooks, and operational evidence.
- **AI Harness** repeatedly applies those tracked assets; it does not create policy, waive controls, or replace accountable people.

If actual organizational ownership differs, the work item must name the authoritative owner. This file defines the harness role model, not an organizational approval by itself.

## Git as SSOT

Track source, requirement, architecture, API/event schema, ADR, rules, skills, tests, runbook, approvals, review findings, and release evidence. Decisions made outside Git must be linked or summarized with an immutable reference. Never store secrets or regulated payloads as evidence.

## Mandatory Human Gates

| Gate | Required human decision | Minimum evidence |
|---|---|---|
| G1 Requirement | Scope and acceptance criteria approved | approver, UTC timestamp, ticket/meeting/PR reference |
| G2 Plan | Design, tasks, validation, rollback approved | architecture/security/domain decision references |
| G3 PR | Code and AI review disposition approved | CI evidence, resolved blockers, developer approval |
| G4 Release | Production execution authorized | change ticket, artifact, window, operator, rollback owner |

AI cannot populate a human approval. Material edits invalidate prior approval and require the document to return to `Draft`.

## Separation of duties

The implementation author must not be the sole reviewer. The AI reviewer is the first pass only. Protected branch merge and production deployment remain restricted to authorized humans/platform identities. Every exception must include owner, reason, expiry, compensating control, and approval.

## Measures

Evaluate Lead Time, Human Touch Time, escaped defects, rework rate, PR review time, change failure rate, and recovery time. Do not use AI-generated lines of code as the primary success measure.
