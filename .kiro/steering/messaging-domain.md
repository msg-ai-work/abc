---
inclusion: auto
name: messaging-domain
description: Enterprise messaging domain rules for message APIs, Kafka, delivery state, retries, deduplication, Redis, databases, and throughput changes.
---

# Enterprise Messaging Domain

For every messaging change, make the delivery semantics explicit: accepted, persisted, published, consumed, delivered, failed, expired, or dead-lettered. Do not use ambiguous success language.

- Define an idempotency key and deduplication scope for every retried producer or consumer path.
- Bound timeouts, retry count, retry interval/backoff, jitter, and total retry budget.
- Distinguish transient, permanent, validation, throttling, and unknown failures.
- Preserve ordering only where required and state the partition key and hot-partition risk.
- Define DLQ ownership, replay safety, retention, alerting, and poison-message handling.
- Define transaction boundaries across database, cache, and broker; use an approved outbox/inbox pattern when atomicity crosses systems.
- Use correlation IDs and safe metadata for observability; never expose message body or recipient PII in logs.
- Validate unit, API contract, integration, Kafka, Redis, database, and TPS/latency impact as applicable.
- Include duplicate delivery, delayed delivery, partial outage, dependency timeout, and replay in failure analysis.

Apply the detailed rules in `ai/rules/messaging-domain.md`, `ai/rules/api.md`, and `ai/rules/kafka.md`.
