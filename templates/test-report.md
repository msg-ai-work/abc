# 테스트 및 검증 보고서

- **Work ID:** `<WORK-ID>`
- **Status:** `Draft`
- **구현 Commit:** `<commit SHA>`
- **Tester:** `<agent/human>`
- **환경:** `<local/CI/non-production; versions>`
- **시작/종료 시각 (UTC):** `<timestamps>`

## 요약

- 전체 증적 결과: `<Pass | Fail | Blocked | Partial>`
- 인수 기준: `<passed>/<total>`
- 필수 실패/Blocker: `<없음 또는 ID>`
- 미검증/잔여 위험: `<없음 또는 ID>`

## 인수 기준 및 위험 추적성

| 요구사항/위험 | 점검 항목 | 결과 | 증적/참조 |
|---|---|---|---|
| `AC-1` | `<Test/절차>` | `<Pass/Fail/Blocked/Not Run>` | `<출력/보고서>` |

## 실행한 명령

| UTC 시각 | 정확한 명령/절차 | Exit | 관찰 결과 | 증적 |
|---|---|---:|---|---|
| `<시간>` | `<유한한 명령>` | `<코드>` | `<기대값이 아닌 실제 관찰 사실>` | `<경로/링크>` |

## 메시징 신뢰성 검증 매트릭스

| 시나리오 | 적용 여부 | 결과/증적 |
|---|---|---|
| 동일 Idempotency Key + 동일/다른 Payload | `<yes/no + 이유>` | `<결과>` |
| 중복 전달 및 Replay | `<...>` | `<...>` |
| Timeout, 일시적 Retry, Retry Exhaustion | `<...>` | `<...>` |
| 영구/Validation 실패 및 DLQ | `<...>` | `<...>` |
| Ordering, Concurrency, Rebalance | `<...>` | `<...>` |
| 부분 DB/Redis/Kafka/하위 시스템 장애 | `<...>` | `<...>` |
| Migration, Mixed Version, Rollback | `<...>` | `<...>` |

## 성능 및 자원 사용 증적

Workload, Payload, TPS/Burst, 수행 시간, Partition/Concurrency, p50/p95/p99, Error, CPU/Memory, Connection/Thread, Lag, DB/Redis Saturation, Baseline 비교, 제약사항을 기록한다. 해당되지 않는 경우 그 이유를 명시한다.

## 결함, Blocker 및 미검증 영역

| ID | 심각도 | 증적/영향 | Owner/다음 조치 |
|---|---|---|---|
| `<VAL-1>` | `<...>` | `<...>` | `<사람/팀>` |

## 잔여 위험 의사결정

> AI는 위험을 승인하거나 면제할 수 없다.

- **결정:** `<Pending | Accepted | Rejected>`
- **사람 Owner:** `<식별자>`
- **시각/증적:** `<UTC 및 참조>`
