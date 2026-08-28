# AI First-Pass Review Report

- **Work ID:** `<WORK-ID>`
- **Status:** `Draft`
- **Reviewed diff/commit:** `<immutable reference>`
- **Reviewer:** `<AI agent/version or human>`
- **Reviewed at (UTC):** `<timestamp>`

## Advisory verdict

`<BLOCK | CHANGES REQUIRED | NO BLOCKING FINDINGS>`

This verdict is advisory and is not PR approval. A human developer owns final review and merge.

## Scope and evidence reviewed

- Approved requirement/plan: `<references>`
- Diff and surrounding execution paths: `<references>`
- Test/CI/security evidence: `<references>`
- Not reviewed/limitations: `<explicit gaps>`

## Findings

| ID | Severity | Location/evidence | Failure or abuse scenario and impact | Required remediation |
|---|---|---|---|---|
| REV-1 | `<BLOCKER/HIGH/MEDIUM/LOW/NOTE>` | `<file:line/reference>` | `<specific behavior>` | `<actionable fix>` |

## Review checklist

- [ ] Approved scope and acceptance criteria are satisfied without hidden changes.
- [ ] API/event/data compatibility and migration are safe.
- [ ] State transitions, transactions, concurrency, and failures are correct.
- [ ] Idempotency, duplicate handling, ordering, timeout, retry, DLQ, and replay are safe.
- [ ] Authentication, authorization, tenant/data boundaries, secrets, and logging are safe.
- [ ] Metrics, alerts, capacity, rollout, reconciliation, and rollback are operationally viable.
- [ ] Validation evidence is sufficient and reproducible.

## Finding disposition

| Finding | Resolution/evidence | AI recheck | Human disposition |
|---|---|---|---|
| `REV-1` | `<commit/test>` | `<resolved/open>` | `<pending/accepted/rejected>` |

## Human PR decision — G3

> AI must not populate approval or merge evidence.

- **Decision:** `<Pending | Approved | Rejected>`
- **Developer approver:** `<human identity>`
- **Timestamp (UTC):** `<timestamp>`
- **PR/merge evidence:** `<reference>`
