# 기업메시징 도메인 규칙

## 메시지 식별자와 상태

- 식별자를 역할별로 구분한다. `messageId`는 논리적 메시지 식별자, `correlationId`는 End-to-End 흐름 식별자, `causationId`는 필요 시 트리거 Event 식별자로 사용한다.
- 하나의 권위 있는 State Machine을 정의한다. 권장 상태는 `ACCEPTED`, `PERSISTED`, `PUBLISHED`, `CONSUMED`, `DELIVERED`, `FAILED`, `EXPIRED`, `DEAD_LETTERED`이며, 시스템이 실제로 증명할 수 있는 상태만 사용한다.
- API 접수 성공이 어느 Durability Boundary까지 의미하는지 명확히 정의한다. 최종 전달이 동기적으로 증명되지 않는 한 HTTP Success가 Downstream Delivery 완료를 의미해서는 안 된다.
- State Transition은 단조롭게 진행되거나 명시적인 Version/Compare-and-set 보호를 사용한다. 늦게 도착한 Event가 Terminal State를 이전 상태로 되돌려서는 안 된다.

## Delivery와 Idempotency

- 더 강한 End-to-End 보장이 입증되지 않는 한 At-least-once Delivery를 기본 가정으로 한다.
- 재시도 가능한 Producer, Consumer, Delivery Operation은 Idempotency Key, Uniqueness Scope, Storage Strategy, 최대 Replay Window보다 긴 TTL/Retention을 정의해야 한다.
- Check-and-act 방식의 Deduplication은 Atomic해야 한다. Process Local Memory보다 Database Unique Constraint, Transactional Inbox 또는 동등한 Atomic Primitive를 우선한다.
- 동일 Key/동일 Payload와 동일 Key/다른 Payload의 처리 규칙을 정의한다. 충돌하는 재사용은 거부하고 안전하게 Audit한다.

## Retry와 Failure

- Connect, Request, Processing, Acknowledgement Timeout을 명시적으로 설정한다.
- Attempt 수, Exponential Backoff, Jitter, 최대 Interval, 전체 Retry Budget을 제한한다. API, Service, Client, Consumer 계층에서 Retry가 곱셈식으로 중첩되지 않도록 한다.
- Validation/Permanent Failure는 Non-retryable로, 일시적인 Dependency Failure는 Retryable로 분류한다. Throttling은 Backoff 또는 Server Hint를 따라야 한다.
- DLQ는 Owner, Retention, Alert, Reason Metadata, Masking된 Diagnostic Context, Replay Authorization, Idempotent Replay Procedure를 가져야 한다.
- Poison Message가 Partition을 무기한 막지 않도록 한다.

## Ordering, Concurrency, Transaction

- Ordering은 문서화된 Business Invariant가 필요한 경우에만 요구한다. Partition/Ordering Key, Concurrency, Hot-key Limit, Rebalance 동작을 정의한다.
- Database/Cache/Broker 간 Transaction Boundary를 명확히 한다. Distributed Atomicity가 존재한다고 가정하지 않는다.
- Database-to-Broker 일관성이 필요한 경우 승인된 Transactional Outbox를 사용하고, Consumer는 필요 시 Inbox/Deduplication 전략을 사용한다.
- Cache를 유일한 Durable Record로 사용하지 않는다. Redis Key Namespace, TTL, Atomic Command/Script, Fail-open/Fail-closed 동작, Eviction 영향, Recovery Source를 정의한다.

## Observability와 Capacity

- Allow-list 기반 Metadata만 기록한다: Correlation ID, Message Type/Version, 안전한 State, Attempt, Latency, Outcome, Normalized Error Code.
- Message Body, Recipient Address, Subscriber ID, Credential, Token, 임의 Header를 기록하지 않는다.
- Accepted/Published/Consumed/Delivered/Failed/DLQ Rate, Retry Count, Duplicate Suppression, Lag, Age, Latency Percentile, Saturation, Reconciliation Mismatch를 추적한다.
- Expected/Peak TPS, Burst Duration, Payload Size, Partition 수, Consumer Concurrency, Downstream Quota, Backpressure, Degradation 동작을 정의한다.
