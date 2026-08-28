# Bugfix Workflow

Use the same G1–G4 gates as the feature workflow, scaled to risk but never skipped without an approved exception.

1. Create `REQUIREMENT.md` with observed vs expected behavior, impact, frequency, affected versions, safe reproduction, and source evidence. Remove PII/secrets from logs and samples.
2. Before proposing a fix, locate the first incorrect state transition and distinguish root cause from symptom. Document why existing controls/tests failed.
3. In `impact-analysis.md`, cover duplicates, retries, ordering, partial failure, concurrency, stale cache, schema/version, and data repair implications.
4. In `implementation-plan.md`, include the smallest safe correction, regression test, compatibility, migration/repair decision, telemetry, rollout, and rollback.
5. Implement only after G1/G2 approval. Preserve a failing regression demonstration when feasible, then show it passes after the fix.
6. `test-report.md` must cover the original failure, adjacent paths, replay/duplicate behavior, and any data reconciliation procedure using synthetic/non-production data.
7. AI and human PR reviews determine whether the fix introduces hidden state, retry storms, data loss, duplicate delivery, or observability gaps.
8. Release records define affected versions, repair/replay ownership, success signals, and rollback limitations.

For urgent production incidents, use `incident.md`; never grant an Agent production access.
