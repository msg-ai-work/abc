---
name: ai-pr-review
description: Perform an independent first-pass PR review for enterprise messaging correctness, security, reliability, and approved-scope compliance.
metadata:
  owner: engineering-governance
  version: "1.0"
---

# AI PR Review

Use `templates/review-report.md`. Review the complete diff and relevant surrounding code; do not infer behavior from filenames alone.

## Review order

1. **Contract:** diff matches approved requirements and plan; no hidden scope or unapproved breaking change.
2. **Correctness:** state transitions, edge cases, exceptions, concurrency, transactions, null/boundary behavior.
3. **Messaging:** idempotency, duplicate handling, ordering, partitioning, timeout, bounded retries, DLQ/replay, poison messages, outbox/inbox consistency.
4. **Security/data:** authentication/authorization, injection, secrets, PII logs, unsafe deserialization, data retention and audit.
5. **Compatibility/operations:** API/event/schema evolution, config defaults, migration, rollback, metrics, alerts, resource and TPS/latency effects.
6. **Evidence:** tests cover acceptance criteria and failure paths; commands/results are reproducible.

## Finding format

Assign `BLOCKER`, `HIGH`, `MEDIUM`, `LOW`, or `NOTE`. Include location, evidence, impact/scenario, and concrete remediation. Do not report pure preference as a defect. State uncertainty explicitly.

The AI verdict is advisory. It cannot approve or merge the PR; a human developer owns final disposition.
