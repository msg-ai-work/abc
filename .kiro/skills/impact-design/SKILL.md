---
name: impact-design
description: Analyze an approved messaging requirement and produce impact analysis plus a file-level implementation plan. Use before changing application code, contracts, schemas, or infrastructure.
metadata:
  owner: architecture
  version: "1.0"
---

# Impact Analysis and Design

Require an approved `REQUIREMENT.md`. Use `templates/impact-analysis.md` and `templates/implementation-plan.md`.

## Investigation

1. Trace entry points through API, service, persistence/cache, producer, broker, consumer, and downstream delivery paths.
2. Identify existing contracts, conventions, ownership boundaries, tests, configuration, dashboards, alerts, runbooks, and migrations.
3. Record impacted files and components with evidence; distinguish direct, indirect, operational, and no-impact areas.
4. Model success and failures: duplicate, timeout, partial outage, reordering, poison message, replay, stale cache, DB/broker divergence, and downstream throttling.

## Design

- Define state transitions, transaction boundaries, delivery guarantees, idempotency key/storage/TTL, partition key, retry budget, DLQ/replay, and compensation.
- Define compatibility and migration sequencing for APIs, events, databases, Redis, and configuration.
- Define data classification, authorization, safe logging, audit events, and secret handling.
- Define SLI/SLO impact, metrics, traces, alerts, capacity assumptions, TPS/latency checks, and rollback triggers.
- Create ordered, file-level tasks linked to requirement IDs and validation commands.

## Gate

Set the plan to `Awaiting Approval`; never approve it. Any unresolved decision affecting correctness, security, data, compatibility, or rollback blocks implementation.
