---
name: requirement-contract
description: Create a traceable enterprise messaging requirement contract. Use when a feature, bug, policy, or operational change must be clarified before design or implementation.
metadata:
  owner: governance
  version: "1.0"
---

# Requirement Contract

Use `templates/REQUIREMENT.md` and write the result to `docs/work-items/<work-id>/REQUIREMENT.md`.

## Procedure

1. Confirm a traceable work ID, requester, business outcome, users/systems affected, and requested delivery date. Mark unknown values; do not invent them.
2. Separate current behavior, desired behavior, constraints, assumptions, and out-of-scope items.
3. Express each acceptance criterion as `AC-<n>` with observable Given/When/Then or equivalent measurable conditions.
4. Define message lifecycle states and whether API acceptance means validation, persistence, publication, or final delivery.
5. Capture API/event compatibility, idempotency, ordering, retry, timeout, DLQ, transaction, Redis/database, observability, privacy, retention, and TPS/latency needs where applicable.
6. Classify data and list external systems, owners, permissions, migration needs, and failure impacts.
7. Map every requirement to a source or mark it as an assumption/open question.
8. Assess initial risk as Low/Medium/High with reasons. High-risk work requires explicit security/architecture review.
9. Set `Status: Awaiting Approval` only when blockers are visible and criteria are testable.

## Gate

Do not design or implement. A human must fill the approval record and set `Status: Approved`. If any required decision is unresolved, retain `Draft`.
