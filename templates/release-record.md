# Release and Rollback Record

- **Work ID:** `<WORK-ID>`
- **Status:** `Draft`
- **Source commit / merged PR:** `<immutable references>`
- **Artifact version and digest:** `<immutable identity>`
- **Target environment:** `<environment>`
- **Release owner/operator:** `<authorized humans/platform identity>`

## Readiness evidence

| Gate/evidence | Reference | Result |
|---|---|---|
| G1 requirement | `./REQUIREMENT.md` | `<verified/pending>` |
| G2 plan | `./implementation-plan.md` | `<verified/pending>` |
| Validation | `./test-report.md` | `<acceptable/pending>` |
| G3 PR/review | `./review-report.md` | `<verified/pending>` |
| Artifact/provenance/security | `<CI reference>` | `<verified/pending>` |

## Change and compatibility

Summarize behavior, API/event/schema, Kafka topic/consumer, database/Redis migration, configuration/secret references, dependencies, mixed-version behavior, retention/deletion, and capacity impact.

## Operator checklist

- [ ] Artifact digest and approvals verified.
- [ ] Backup/reconciliation prerequisites complete.
- [ ] Config and secret **references** present; values are not recorded here.
- [ ] Migration order and backward compatibility verified.
- [ ] Dashboards, alerts, on-call, communication, and maintenance window ready.
- [ ] Canary/phased rollout and observation window agreed.
- [ ] Rollback decision owner and operator available.

## Rollout, verification, and rollback

- Authorized operator procedure: `<reviewed platform/runbook steps; Agent does not execute>`
- Success metrics/threshold/window: `<signals>`
- Rollback triggers: `<objective thresholds>`
- Rollback procedure: `<artifact/config/schema steps>`
- Data reconciliation and message replay safety: `<steps/owner>`
- Irreversible effects/limitations: `<details>`

## Production authorization — G4

> AI must not approve, deploy, or populate actual outcome.

- **Decision:** `<Pending | Approved | Rejected>`
- **Approver:** `<authorized human>`
- **Change ticket/window:** `<reference/time>`
- **Timestamp (UTC):** `<timestamp>`
- **Evidence:** `<reference>`

## Actual outcome — operator record

- **Outcome:** `Pending operator record`
- **Started/finished (UTC):** `<human supplied>`
- **Deployed artifact digest:** `<human/platform supplied>`
- **Observed metrics/incidents:** `<evidence>`
- **Rollback/reconciliation performed:** `<evidence or none>`
- **Post-release approval/closure:** `<human reference>`
