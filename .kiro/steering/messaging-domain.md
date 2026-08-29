---
inclusion: auto
name: messaging-domain
description: 메시지 API, Kafka, 전달 상태, 재시도, 중복 제거, Redis, 데이터베이스, 처리량 변경에 적용하는 기업메시징 도메인 규칙.
---

# 기업메시징 도메인 규칙

모든 메시징 변경에서는 전달 상태의 의미를 명확하게 정의한다. 예: 접수(accepted), 저장(persisted), 발행(published), 소비(consumed), 전달(delivered), 실패(failed), 만료(expired), DLQ 이동(dead-lettered). 모호한 성공 표현은 사용하지 않는다.

- 재시도가 발생하는 Producer 또는 Consumer 경로에는 반드시 멱등성 키와 중복 제거 범위를 정의한다.
- Timeout, Retry 횟수, Retry 간격/Backoff, Jitter, 전체 Retry Budget의 상한을 명확히 정의한다.
- 일시적 오류, 영구 오류, 검증 오류, Throttling 오류, 원인 미확인 오류를 구분한다.
- 순서 보장이 필요한 경우에만 Ordering을 유지하며, Partition Key와 Hot Partition 위험을 함께 명시한다.
- DLQ의 담당 주체, Replay 안전성, 보관 기간, Alert 기준, Poison Message 처리 방안을 정의한다.
- Database, Cache, Broker 간 Transaction 경계를 정의하고, 시스템 간 원자성이 필요한 경우 승인된 Outbox/Inbox 패턴을 사용한다.
- 관측성을 위해 Correlation ID와 안전한 Metadata를 사용하며, 로그에는 메시지 본문이나 수신자 개인정보를 노출하지 않는다.
- 변경 범위에 따라 Unit, API Contract, Integration, Kafka, Redis, Database, TPS/Latency 영향을 검증한다.
- 장애 분석에는 중복 전달, 지연 전달, 부분 장애, 연계 시스템 Timeout, Replay 상황을 포함한다.

세부 규칙은 `ai/rules/messaging-domain.md`, `ai/rules/api.md`, `ai/rules/kafka.md`를 함께 적용한다.
