# 품질 및 증적 규칙

## 위험 기반 검증

모든 Acceptance Criterion과 Design Risk는 검증 방법 또는 명시적인 `Not Run` 위험과 연결되어야 한다. 적용 가능한 Layer를 선택한다: Unit, API Contract, Component, Integration, Kafka, Redis, Database/Migration, 비운영 환경 End-to-End, Security, Resilience, Performance.

메시징 변경은 일반적으로 Duplicate Delivery, Idempotency Conflict, Timeout, Retry Exhaustion, Permanent Failure, Ordering/Concurrency, DLQ/Replay, Partial Dependency Outage에 대한 증적이 필요하다. 해당하지 않는 경우에는 사유를 기록한다.

## 재현 가능성

정확한 유한 실행 Command, Environment, UTC Time, Exit Code, Observed Result, Evidence Reference를 기록한다. 실제 관측 결과가 없는 생성 Report는 계획일 뿐 증적이 아니다. Failure를 변경하거나 누락하지 않는다. Synthetic Data와 Non-production Dependency를 사용한다.

## 성능

Throughput 또는 Latency가 변경될 가능성이 있으면 동일한 Payload, TPS, Burst, Partition, Concurrency, Dependency 조건에서 Baseline과 Candidate 결과를 비교한다. p50/p95/p99 Latency, Throughput, Error, CPU, Memory, Thread/Connection, Broker Lag, Database/Cache Saturation, Backpressure를 기록한다. Sample Size와 제한사항도 명시한다.

## 종료 기준

필수 Check가 통과하고, Acceptance Coverage가 추적 가능하며, Blocker가 해결되고, 미검증/잔여 Risk에 Owner가 지정되어야 Review Ready 상태로 판단한다. AI는 처리 방향을 권고할 수 있지만 Gate 면제나 Residual Risk 수용은 권한 있는 사람만 할 수 있다.
