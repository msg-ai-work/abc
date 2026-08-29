# Kafka 규칙

## Contract와 Naming

- 기존 Topic Registry와 조직 표준을 우선 적용한다. 표준이 없으면 `<environment>.<domain>.<event-or-stream>.v<major>` 형식을 제안하고, 생성 전 Architecture 승인을 받는다.
- Event 이름은 발생한 사실을 과거형으로 표현하고, Command 이름은 의도를 표현한다. Owner, 목적, Data Classification, Producer, Consumer, Partition Key, Retention, SLO를 기록한다.
- 관리되는 Schema와 Compatibility Mode를 사용한다. 기존 Field Number/Name을 다른 의미로 재사용하지 않으며, Breaking Change는 명확한 Version 변경으로 관리한다.

## Producer

- Key 선택, Partition 분산, Acknowledgement/Durability, Serialization 실패 처리, Timeout, 제한된 Retry 정책을 정의한다.
- Database와 Kafka가 원자적으로 함께 변경되어야 하면 승인된 Outbox Pattern을 사용해 일관성을 유지한다.
- Key, Header, Payload에 Secret이나 불필요한 PII를 넣지 않는다. Broker Data와 Header가 운영 도구에서 노출될 수 있다고 가정한다.

## Consumer

- Consumer는 Duplicate Delivery, Retry, Restart, Rebalance 상황에서도 Idempotent하게 동작해야 한다.
- 필요한 Durable Side Effect가 완료된 후에만 Acknowledge/Commit한다. Batch 처리 시 Partial Failure 동작을 명확히 정의한다.
- Poll/Session 설정과 비교해 Concurrency와 Processing Time을 제한한다. 긴 처리로 인해 통제되지 않은 Rebalance Loop가 발생하지 않도록 한다.
- Retry 전 Error를 분류한다. Retry를 모두 소진했거나 Permanent Failure인 경우에는 Owner가 명확한 DLQ로 보내고 안전한 Metadata와 Alerting을 제공한다.

## Ordering, Replay, 운영

- Ordering은 Partition 내부에서만 보장된다. Business Key, Hot Partition 위험, Partition 수 변경 영향, Key 간 Non-ordering을 문서화한다.
- Replay는 Authorization, 제한된 범위, Dry-run/Estimate, Idempotency, Downstream Capacity 확인, Monitoring, Audit Record가 필요하다.
- Produce/Consume Error Rate, Request Latency, Consumer Lag 및 Record Age, Retry/DLQ Rate, Rebalance, Partition Skew, Under-replication을 모니터링한다.
- Retention과 Compaction 정책은 Recovery, Deduplication, Privacy, Deletion 요구사항과 일치해야 한다.
