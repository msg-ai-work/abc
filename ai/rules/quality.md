# Quality and Evidence Rules

## Risk-based validation

Every acceptance criterion and design risk must map to a validation method or an explicit `Not Run` risk. Select applicable layers: unit, API contract, component, integration, Kafka, Redis, database/migration, end-to-end in a non-production environment, security, resilience, and performance.

Messaging changes normally require evidence for duplicate delivery, idempotency conflict, timeout, retry exhaustion, permanent failure, ordering/concurrency, DLQ/replay, and partial dependency outage. Mark non-applicable cases with a reason.

## Reproducibility

Record the exact finite command, environment, UTC time, exit code, observed result, and evidence reference. Generated reports without observed results are plans, not evidence. Never alter or omit failures. Use synthetic data and non-production dependencies.

## Performance

When throughput or latency may change, record baseline and candidate results under comparable payload, TPS, burst, partition, concurrency, and dependency conditions. Report p50/p95/p99 latency, throughput, errors, CPU, memory, threads/connections, broker lag, database/cache saturation, and backpressure. State sample size and limitations.

## Exit criteria

A change is review-ready only when mandatory checks pass, acceptance coverage is traceable, blockers are resolved, and untested/residual risks have owners. AI may recommend disposition; only an authorized human may waive a gate or accept residual risk.
