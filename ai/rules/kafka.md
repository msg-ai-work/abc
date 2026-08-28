# Kafka Rules

## Contracts and naming

- The existing topic registry and organization convention take precedence. If none exists, propose `<environment>.<domain>.<event-or-stream>.v<major>` and require architecture approval before creation.
- Event names describe facts in past tense; command names express intent. Record owner, purpose, classification, producers, consumers, partition key, retention, and SLO.
- Use a governed schema and compatibility mode. Never reuse a field number/name with different semantics; version breaking changes deliberately.

## Producer

- Define key selection, partition distribution, acknowledgement/durability, serialization failure behavior, timeout, and bounded retry.
- Maintain database-to-Kafka consistency with the approved outbox pattern when both must change atomically.
- Do not put secrets or unnecessary PII in key, headers, or payload. Assume broker data and headers may appear in operational tooling.

## Consumer

- Consumers must be idempotent under duplicate delivery, retry, restart, and rebalance.
- Acknowledge/commit only after the required durable side effect. Make batch partial-failure behavior explicit.
- Bound concurrency and processing time relative to poll/session settings. Long processing must not cause uncontrolled rebalance loops.
- Classify errors before retry. Route exhausted/permanent failures to an owned DLQ with safe metadata and alerting.

## Ordering, replay, and operations

- Ordering exists only within a partition. Document the business key, hot-partition risk, partition-count change effect, and cross-key non-ordering.
- Replays require authorization, a bounded range, dry-run/estimate, idempotency, downstream capacity check, monitoring, and audit record.
- Monitor produce/consume error rate, request latency, consumer lag and record age, retry/DLQ rate, rebalance, partition skew, and under-replication.
- Retention and compaction must align with recovery, deduplication, privacy, and deletion requirements.
