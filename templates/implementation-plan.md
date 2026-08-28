# Implementation Plan

- **Work ID:** `<WORK-ID>`
- **Requirement:** `./REQUIREMENT.md`
- **Impact analysis:** `./impact-analysis.md`
- **Status:** `Draft`
- **Plan owner:** `<human owner>`
- **Last updated (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`

## Approval record — G2

> AI must not populate human approval fields.

- **Decision:** `<Pending | Approved | Rejected>`
- **Approver(s):** `<architecture/domain/security humans as applicable>`
- **Approved version/commit:** `<immutable reference>`
- **Timestamp (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`
- **Evidence:** `<ticket/PR reference>`

## Design summary

Describe selected architecture, delivery semantics, state/transaction model, idempotency, ordering, retry/DLQ/replay, compatibility, security, observability, migration, and rollback. Reference decisions instead of duplicating them.

## Ordered implementation tasks

| Task | Requirement/AC | Files/components | Change | Verification | Dependencies |
|---|---|---|---|---|---|
| T-1 | `AC-1` | `<exact paths>` | `<bounded change>` | `<finite command/check>` | `<task/decision>` |

Each task must be independently reviewable. Include contract/schema, code, config, migration, telemetry, tests, docs, and runbook changes as applicable.

## Validation plan

| Risk/criterion | Layer | Environment/fixture | Exact command or procedure | Expected evidence |
|---|---|---|---|---|
| `AC-1` | `<unit/API/Kafka/etc.>` | `<non-production>` | `<command>` | `<observable result>` |

Include duplicate, timeout, retry exhaustion, permanent failure, ordering/concurrency, partial outage, DLQ/replay, database/Redis, compatibility, and TPS/latency checks where applicable.

## Rollout and rollback

- Migration and mixed-version sequence: `<steps>`
- Feature flag/canary/phases: `<steps or n/a>`
- Success signals and observation window: `<metrics/threshold/time>`
- Rollback triggers and owner: `<criteria/human>`
- Rollback/data reconciliation/replay: `<safe steps>`

## Risks and stop conditions

| Risk/decision | Owner | Required before task/release |
|---|---|---|
| `<risk>` | `<human>` | `<evidence>` |

## Implementation evidence

> Developer records observed facts here; material deviations reset this plan to Draft and require reapproval.

- Changed files: `<paths>`
- Commands/results: `<exact command, UTC time, exit/result>`
- Deviations: `<none or approved reference>`
- Residual risks: `<none or owner/disposition>`
