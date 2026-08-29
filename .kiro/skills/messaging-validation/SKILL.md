---
name: messaging-validation
description: 기업메시징 동작을 검증하고 재현 가능한 테스트 보고서를 작성한다. 구현 완료 후 또는 신뢰성, 호환성, 성능 위험을 평가할 때 사용한다.
metadata:
  owner: quality
  version: "1.0"
---

# 메시징 검증

`templates/test-report.md`를 사용한다. 실제로 수행하지 않은 점검을 수행했다고 기록하지 않는다.

## 검증 범위 선정

모든 수용 기준과 설계 위험을 다음 중 하나 이상에 매핑한다.

- Unit/상태 전이 테스트
- API Schema, Status, Validation, Compatibility, Timeout, Idempotency 점검
- Producer/Consumer 직렬화 및 계약 점검
- Broker 통합 점검: Key/Partition, Retry, Duplicate, DLQ, Replay, Rebalancing
- Redis TTL, Atomicity, Eviction, Deduplication 점검
- Database Constraint, Transaction, Locking, Migration, Rollback 점검
- Dependency Timeout, 부분 장애, Throttling, Recovery 점검
- 동시성, 순서보장, TPS, Latency Percentile, Resource Saturation, Backpressure 점검

## 증적 규칙

각 명령에 대해 UTC 시간, 환경, 명령어, 종료 코드, 관찰 결과, 증적 위치를 기록한다. 민감정보가 없는 합성 테스트 데이터를 사용한다. 결과는 Pass, Fail, Blocked, Not Run으로 구분한다. 환경이나 의존성이 없어 수행할 수 없는 경우는 Pass가 아니라 Blocked로 기록한다.

## 종료 기준

수용 기준 커버리지, 회귀 범위, 실패 항목, 미검증 위험, 권고 결론을 요약한다. 잔여 위험을 수용하거나 필수 실패 항목을 면제할 수 있는 주체는 사람뿐이다.
