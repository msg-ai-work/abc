# Observability Rules

Define observable outcomes before implementation. Metrics, logs, traces, dashboards, and alerts must distinguish accepted, persisted, published, consumed, delivered, failed, expired, retried, duplicate-suppressed, and dead-lettered states where applicable.

## Telemetry

- Use low-cardinality metric labels. Never use message ID, recipient, subscriber, free text, or payload as a metric label.
- Structured logs use approved event names, normalized error codes, correlation ID, safe message type/version, attempt, duration, and outcome.
- Traces propagate validated correlation/trace context without arbitrary headers or sensitive baggage.
- Sampling must retain errors and rare critical paths without collecting prohibited data.

## Alerts and SLOs

Alert on user-impacting symptoms and exhausted error budgets rather than single transient failures. Define threshold, evaluation window, severity, owner, runbook, and deduplication. Cover delivery failure, lag/age, retry/DLQ growth, reconciliation mismatch, dependency saturation, and latency as applicable.

## Change requirements

Every material behavior change must state dashboard/alert impact, rollout signals, success window, rollback triggers, and how operators distinguish old/new versions. Telemetry names and retention follow existing organization standards; deviations require approval.
