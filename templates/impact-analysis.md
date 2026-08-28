# Impact Analysis

- **Work ID:** `<WORK-ID>`
- **Requirement:** `./REQUIREMENT.md`
- **Status:** `Draft`
- **Analyst:** `<agent/human>`
- **Last updated (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`
- **Analyzed commit:** `<commit SHA>`

## Preconditions

- Requirement status/evidence verified: `<yes/no and reference>`
- Unknowns that block reliable analysis: `<none or list>`

## Current execution path

Describe and cite the path from API/scheduler through service, database/Redis, producer, Kafka, consumer, and downstream delivery. Include current state, transaction, retry, and acknowledgement boundaries.

## Impact matrix

| Area | Evidence (file/schema/config) | Direct/indirect/no impact | Required change/risk |
|---|---|---|---|
| API/contracts | `<path>` | `<impact>` | `<detail>` |
| Events/Kafka | `<path>` | `<impact>` | `<detail>` |
| Database/Redis | `<path>` | `<impact>` | `<detail>` |
| Security/data | `<path>` | `<impact>` | `<detail>` |
| Operations/SLO | `<path>` | `<impact>` | `<detail>` |
| Tests/CI/CD | `<path>` | `<impact>` | `<detail>` |

## State, delivery, and transaction analysis

- State transitions and source of truth: `<analysis>`
- Delivery/idempotency/duplicate behavior: `<analysis>`
- Ordering, partitioning, and concurrency: `<analysis>`
- DB/cache/broker transaction boundaries: `<analysis>`
- Timeout, retry budget, DLQ, replay: `<analysis>`

## Failure-mode analysis

| Scenario | Current behavior | Proposed behavior | Detection | Recovery/data risk |
|---|---|---|---|---|
| Duplicate/replay | `<...>` | `<...>` | `<...>` | `<...>` |
| Dependency timeout/outage | `<...>` | `<...>` | `<...>` | `<...>` |
| Partial DB/cache/broker success | `<...>` | `<...>` | `<...>` | `<...>` |
| Poison/out-of-order message | `<...>` | `<...>` | `<...>` | `<...>` |

## Compatibility and migration

- API/event/schema compatibility: `<analysis>`
- Database/cache/config migration order: `<analysis>`
- Mixed-version deployment behavior: `<analysis>`
- Data repair/reconciliation: `<analysis>`

## Security and operations

- Trust/authorization/data boundaries: `<analysis>`
- Sensitive logging/retention implications: `<analysis>`
- Capacity/TPS/latency/backpressure: `<analysis>`
- Metrics, dashboards, alerts, runbooks: `<analysis>`
- Rollback feasibility and triggers: `<analysis>`

## Options and decision

| Option | Benefits | Costs/risks | Decision |
|---|---|---|---|
| `<option>` | `<...>` | `<...>` | `<selected/rejected and why>` |

## Open decisions and rule exceptions

List owner and due date. Exceptions require documented approval, expiry, and compensating controls.
