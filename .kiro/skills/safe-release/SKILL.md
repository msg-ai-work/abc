---
name: safe-release
description: Prepare an auditable enterprise messaging release and rollback record without executing production deployment.
metadata:
  owner: release-management
  version: "1.0"
---

# Safe Release Preparation

Use `templates/release-record.md`.

## Preconditions

Confirm the immutable artifact/version, merged PR, approved requirement and plan, acceptable test report, resolved blocking review findings, migration review, rollback viability, and named human release authorization. Missing evidence blocks readiness.

## Record

- artifact digest/version, source commit, dependency/config/secret-reference changes;
- API/event/database/Redis/Kafka compatibility and rollout order;
- pre-deployment backup/checks and authorized operator steps;
- canary/phased rollout, dashboards, alert thresholds, success window, and owner;
- rollback triggers, decision owner, exact operator procedure, data reconciliation, and replay safety;
- communication, maintenance window, incident escalation, and post-release validation;
- links to CI, approvals, change ticket, and eventual operator-recorded outcome.

## Boundary

Never connect to production or execute deployment/rollback commands. Prepare commands only as reviewed instructions for an authorized operator. Keep actual outcome `Pending operator record` until a human supplies evidence.
