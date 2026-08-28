# Java and Spring Rules

## Baseline

Follow the repository's pinned JDK, Spring Boot, build tool, formatting, and architecture. Do not upgrade frameworks or add dependencies outside an approved plan. Pin new dependency versions and verify provenance/license through the organization's approved process.

## Design

- Keep controllers and message listeners as transport adapters; place business state transitions in application/domain services.
- Use constructor injection and immutable dependencies. Avoid field injection and global mutable state.
- Use typed configuration properties with startup validation. Defaults must never point to production.
- Separate transport DTOs/events from persistence entities. Validate at trust boundaries and use explicit mapping.
- Do not expose internal exceptions, stack traces, database details, or sensitive payload fragments.

## Transactions and messaging

- Put `@Transactional` boundaries on public service operations with a documented database scope. Do not assume a transaction spans Kafka, Redis, HTTP, and database.
- Avoid remote calls inside long database transactions. Use outbox/inbox or compensation according to the approved design.
- Configure Kafka acknowledgement, error handler, retry, and DLQ behavior explicitly. Consumer handlers must be idempotent.
- Set timeouts on HTTP, database, Redis, and broker clients. Avoid unbounded pools, queues, retries, futures, and blocking waits.
- Preserve interrupt status and classify exceptions into retryable/permanent outcomes without blanket catch-and-ignore.

## Logging and observability

Use structured parameterized logs with allow-listed fields. Never concatenate or serialize request/message bodies, PII, credentials, tokens, or arbitrary headers. Propagate correlation context safely across async boundaries and clear thread-local context.

## Validation

Prefer focused unit tests for state logic and integration/contract tests for serialization, transactions, broker/cache/database behavior. Use deterministic time, IDs, and retry policies in tests. Do not connect automated tests to production services.
