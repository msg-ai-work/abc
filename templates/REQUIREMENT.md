# Requirement Contract

- **Work ID:** `<WORK-ID>`
- **Title:** `<concise title>`
- **Status:** `Draft`
- **Risk:** `<Low | Medium | High>`
- **Owner:** `<human owner>`
- **Last updated (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`

## Approval record — G1

> AI must not populate human approval fields.

- **Decision:** `<Pending | Approved | Rejected>`
- **Approver:** `<human identity>`
- **Approved version/commit:** `<immutable reference>`
- **Timestamp (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`
- **Evidence:** `<ticket/PR/meeting reference>`

## Provenance

| Requirement/source | Reference | Fact, assumption, or open question |
|---|---|---|
| `<request>` | `<immutable link or path>` | `<type>` |

## Problem and outcome

### Current behavior
`<observable current state>`

### Desired outcome
`<business/user outcome, not solution>`

### Scope
- In: `<included behavior/systems>`
- Out: `<explicit exclusions>`

## Message semantics

- Acceptance durability boundary: `<validated | persisted | published | delivered | n/a>`
- Lifecycle/state transitions: `<states and terminal states>`
- Delivery guarantee: `<at-most-once | at-least-once | proven end-to-end guarantee>`
- Idempotency/deduplication: `<key, scope, conflict behavior, retention>`
- Ordering/partition key: `<requirement or n/a>`
- Timeout/retry/DLQ/replay: `<bounded requirement or n/a>`
- Transaction/cache/database boundary: `<requirement or n/a>`

## Acceptance criteria

| ID | Given | When | Then / measurable evidence | Priority |
|---|---|---|---|---|
| AC-1 | `<precondition>` | `<action/event>` | `<observable result>` | `<Must/Should>` |

## Non-functional requirements

| Area | Requirement / threshold | Measurement |
|---|---|---|
| TPS and burst | `<value or TBD>` | `<method>` |
| Latency | `<p95/p99 threshold or TBD>` | `<method>` |
| Availability/recovery | `<SLO/RTO/RPO or n/a>` | `<method>` |
| Compatibility | `<API/event/data constraints>` | `<method>` |
| Observability | `<metrics/logs/traces/alerts>` | `<method>` |

## Security, privacy, and compliance

- Data classification and fields: `<classification; no raw sensitive samples>`
- Authentication/authorization/tenant boundary: `<requirements>`
- Logging, retention, deletion, audit: `<requirements>`
- Secret and external-data boundary: `<requirements>`

## Dependencies and ownership

| System/team | Contract or dependency | Owner | Failure impact |
|---|---|---|---|
| `<name>` | `<API/topic/DB/etc.>` | `<human/team>` | `<impact>` |

## Assumptions, constraints, and open questions

- A-1: `<assumption and validation owner>`
- Q-1: `<question, owner, due date>`

## Initial risks

| Risk | Likelihood/impact | Mitigation/decision owner |
|---|---|---|
| `<risk>` | `<L/M/H>` | `<control/owner>` |

## Traceability

- Related ADR/schema/runbook: `<paths>`
- Success KPI: `<Lead Time, quality, defect/rework, etc.>`
