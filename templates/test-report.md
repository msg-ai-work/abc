# Test and Validation Report

- **Work ID:** `<WORK-ID>`
- **Status:** `Draft`
- **Implementation commit:** `<commit SHA>`
- **Tester:** `<agent/human>`
- **Environment:** `<local/CI/non-production; versions>`
- **Started/finished (UTC):** `<timestamps>`

## Summary

- Overall evidence: `<Pass | Fail | Blocked | Partial>`
- Acceptance criteria: `<passed>/<total>`
- Mandatory failures/blockers: `<none or IDs>`
- Untested/residual risks: `<none or IDs>`

## Acceptance and risk traceability

| Requirement/risk | Check | Result | Evidence/reference |
|---|---|---|---|
| `AC-1` | `<test/procedure>` | `<Pass/Fail/Blocked/Not Run>` | `<output/report>` |

## Executed commands

| UTC time | Exact command/procedure | Exit | Observed result | Evidence |
|---|---|---:|---|---|
| `<time>` | `<finite command>` | `<code>` | `<facts, not expected result>` | `<path/link>` |

## Messaging reliability matrix

| Scenario | Applicable? | Result/evidence |
|---|---|---|
| Same idempotency key, same/different payload | `<yes/no + reason>` | `<result>` |
| Duplicate delivery and replay | `<...>` | `<...>` |
| Timeout, transient retry, retry exhaustion | `<...>` | `<...>` |
| Permanent/validation failure and DLQ | `<...>` | `<...>` |
| Ordering, concurrency, rebalance | `<...>` | `<...>` |
| Partial DB/Redis/Kafka/downstream outage | `<...>` | `<...>` |
| Migration, mixed version, rollback | `<...>` | `<...>` |

## Performance and resource evidence

Record workload, payload, TPS/burst, duration, partitions/concurrency, p50/p95/p99, errors, CPU/memory, connections/threads, lag, DB/Redis saturation, baseline comparison, and limitations; or explain why not applicable.

## Defects, blockers, and untested areas

| ID | Severity | Evidence/impact | Owner/next action |
|---|---|---|---|
| `<VAL-1>` | `<...>` | `<...>` | `<human/team>` |

## Residual-risk decision

> AI cannot accept or waive risk.

- **Decision:** `<Pending | Accepted | Rejected>`
- **Human owner:** `<identity>`
- **Timestamp/evidence:** `<UTC and reference>`
