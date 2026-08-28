---
name: messaging-validation
description: Validate enterprise messaging behavior and create a reproducible test report. Use after implementation or when evaluating reliability, compatibility, and performance risk.
metadata:
  owner: quality
  version: "1.0"
---

# Messaging Validation

Use `templates/test-report.md`. Never claim a check that was not run.

## Coverage selection

Map every acceptance criterion and design risk to one or more of:

- unit/state-transition tests;
- API schema, status, validation, compatibility, timeout, and idempotency checks;
- producer/consumer serialization and contract checks;
- broker integration for key/partition, retries, duplicates, DLQ, replay, and rebalancing;
- Redis TTL, atomicity, eviction, and deduplication checks;
- database constraint, transaction, locking, migration, and rollback checks;
- dependency timeout, partial outage, throttling, and recovery checks;
- concurrency, ordering, TPS, latency percentiles, resource saturation, and backpressure checks.

## Evidence rules

For each command record UTC time, environment, command, exit code, observed result, and evidence location. Use synthetic non-sensitive test data. Distinguish Pass, Fail, Blocked, and Not Run. A missing environment or dependency is Blocked, not Pass.

## Exit criteria

Summarize acceptance coverage, regression scope, failures, untested risks, and recommended disposition. Only a human may accept residual risk or waive a failed mandatory check.
