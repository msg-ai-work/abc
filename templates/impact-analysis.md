# 영향 분석서

- **Work ID:** `<WORK-ID>`
- **요구사항:** `./REQUIREMENT.md`
- **Status:** `Draft`
- **분석자:** `<agent/human>`
- **최종 수정 시각 (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`
- **분석 기준 Commit:** `<commit SHA>`

## 사전 조건

- 요구사항 상태/승인 증적 확인: `<yes/no 및 참조>`
- 신뢰할 수 있는 분석을 막는 미확정 사항: `<없음 또는 목록>`

## 현재 실행 경로

API/Scheduler부터 Service, Database/Redis, Producer, Kafka, Consumer, 하위 전달 구간까지 현재 흐름을 설명하고 근거를 남긴다. 현재 상태, Transaction, Retry, Acknowledgement 경계를 포함한다.

## 영향도 매트릭스

| 영역 | 근거(File/Schema/Config) | 직접/간접/영향 없음 | 필요한 변경/위험 |
|---|---|---|---|
| API/Contract | `<경로>` | `<영향>` | `<상세>` |
| Event/Kafka | `<경로>` | `<영향>` | `<상세>` |
| Database/Redis | `<경로>` | `<영향>` | `<상세>` |
| 보안/데이터 | `<경로>` | `<영향>` | `<상세>` |
| 운영/SLO | `<경로>` | `<영향>` | `<상세>` |
| Test/CI/CD | `<경로>` | `<영향>` | `<상세>` |

## 상태, 전달 및 Transaction 분석

- 상태 전이와 SSOT: `<분석>`
- 전달/멱등성/중복 처리: `<분석>`
- 순서 보장, Partitioning, 동시성: `<분석>`
- DB/Cache/Broker Transaction 경계: `<분석>`
- Timeout, Retry Budget, DLQ, Replay: `<분석>`

## 장애 시나리오 분석

| 시나리오 | 현재 동작 | 변경 후 동작 | 탐지 방법 | 복구/데이터 위험 |
|---|---|---|---|---|
| 중복/Replay | `<...>` | `<...>` | `<...>` | `<...>` |
| Dependency Timeout/장애 | `<...>` | `<...>` | `<...>` | `<...>` |
| DB/Cache/Broker 부분 성공 | `<...>` | `<...>` | `<...>` | `<...>` |
| Poison/순서 뒤바뀐 메시지 | `<...>` | `<...>` | `<...>` | `<...>` |

## 호환성과 Migration

- API/Event/Schema 호환성: `<분석>`
- Database/Cache/Config Migration 순서: `<분석>`
- Mixed-version 배포 동작: `<분석>`
- 데이터 보정/Reconciliation: `<분석>`

## 보안 및 운영 영향

- Trust/인가/Data 경계: `<분석>`
- 민감정보 Logging/보관 영향: `<분석>`
- 용량/TPS/Latency/Backpressure: `<분석>`
- Metric, Dashboard, Alert, Runbook: `<분석>`
- Rollback 가능 여부와 Trigger: `<분석>`

## 대안과 의사결정

| 대안 | 장점 | 비용/위험 | 결정 |
|---|---|---|---|
| `<대안>` | `<...>` | `<...>` | `<선택/기각 및 이유>` |

## 미해결 결정사항 및 Rule 예외

Owner와 기한을 기록한다. 예외는 승인, 만료일, 보완 통제를 문서화해야 한다.
