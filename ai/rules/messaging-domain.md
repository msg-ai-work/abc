# Enterprise Messaging Domain Rules

## Message identity and state

- Use distinct identifiers: `messageId` for logical message identity, `correlationId` for an end-to-end flow, and `causationId` for the triggering event when applicable.
- Define one authoritative state machine. Recommended vocabulary is `ACCEPTED`, `PERSISTED`, `PUBLISHED`, `CONSUMED`, `DELIVERED`, `FAILED`, `EXPIRED`, and `DEAD_LETTERED`; use only states that the system can prove.
- API acceptance must state its durability boundary. HTTP success must not imply downstream delivery unless final delivery is synchronously proven.
- State transitions must be monotonic or use explicit version/compare-and-set protection. Late events must not regress terminal state.

## Delivery and idempotency

- Assume at-least-once delivery unless a stronger guarantee is demonstrated end-to-end.
- Every retryable producer, consumer, and delivery operation requires an idempotency key, uniqueness scope, storage strategy, and TTL/retention longer than the maximum replay window.
- Check-and-act deduplication must be atomic. Database unique constraints, transactional inbox, or equivalent atomic primitives are preferred over process-local memory.
- Define behavior for same key/same payload and same key/different payload; conflicting reuse must be rejected and audited safely.

## Retry and failure

- Set connect, request, processing, and acknowledgement timeouts explicitly.
- Bound attempts, exponential backoff, jitter, maximum interval, and total elapsed retry budget. Avoid multiplicative retries across API, service, client, and consumer layers.
- Classify validation/permanent failures as non-retryable; transient dependency failures as retryable; throttling must respect backoff or server hints.
- DLQ requires an owner, retention, alert, reason metadata, redacted diagnostic context, replay authorization, and idempotent replay procedure.
- Poison messages must not block a partition indefinitely.

## Ordering, concurrency, and transactions

- Require ordering only for a documented business invariant. Define partition/ordering key, concurrency, hot-key limits, and rebalance behavior.
- Make database/cache/broker transaction boundaries explicit. Do not imply distributed atomicity.
- Use an approved transactional outbox for database-to-broker consistency and an inbox/deduplication strategy for consumers where required.
- Cache is not the sole durable record. Define Redis key namespace, TTL, atomic command/script, fail-open/fail-closed behavior, eviction effect, and recovery source.

## Observability and capacity

- Emit allow-listed metadata: correlation ID, message type/version, safe state, attempt, latency, outcome, and normalized error code.
- Never emit body, recipient address, subscriber ID, credential, token, or unrestricted headers.
- Track accepted/published/consumed/delivered/failed/DLQ rates, retry count, duplicate suppression, lag, age, latency percentiles, saturation, and reconciliation mismatch.
- Define expected/peak TPS, burst duration, payload size, partitions, consumer concurrency, downstream quota, backpressure, and degradation behavior.
