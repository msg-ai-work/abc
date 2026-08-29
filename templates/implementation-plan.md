# 구현 계획서

- **Work ID:** `<WORK-ID>`
- **요구사항:** `./REQUIREMENT.md`
- **영향 분석:** `./impact-analysis.md`
- **Status:** `Draft`
- **계획 Owner:** `<사람 책임자>`
- **최종 수정 시각 (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`

## 승인 기록 — G2

> AI는 사람의 승인 필드를 직접 작성해서는 안 된다.

- **결정:** `<Pending | Approved | Rejected>`
- **승인자:** `<필요 시 Architecture/Domain/Security 담당자>`
- **승인 버전/Commit:** `<변경 불가능한 참조>`
- **승인 시각 (UTC):** `<YYYY-MM-DDTHH:mm:ssZ>`
- **증적:** `<Ticket/PR 참조>`

## 설계 요약

선택한 Architecture, 전달 의미, 상태/Transaction 모델, 멱등성, 순서 보장, Retry/DLQ/Replay, 호환성, 보안, 관측성, Migration, Rollback 방식을 설명한다. 이미 결정된 내용은 중복 작성하지 말고 관련 의사결정 문서를 참조한다.

## 순서가 있는 구현 Task

| Task | 요구사항/AC | File/Component | 변경 내용 | 검증 방법 | 의존성 |
|---|---|---|---|---|---|
| T-1 | `AC-1` | `<정확한 경로>` | `<범위가 제한된 변경>` | `<유한한 명령/점검>` | `<Task/의사결정>` |

각 Task는 독립적으로 Review 가능해야 한다. 필요 시 Contract/Schema, Code, Config, Migration, Telemetry, Test, 문서, Runbook 변경을 포함한다.

## 검증 계획

| 위험/기준 | 계층 | 환경/Fixture | 정확한 명령 또는 절차 | 기대 증적 |
|---|---|---|---|---|
| `AC-1` | `<Unit/API/Kafka 등>` | `<Non-production>` | `<명령>` | `<관찰 가능한 결과>` |

해당되는 경우 중복, Timeout, Retry Exhaustion, 영구 실패, Ordering/Concurrency, 부분 장애, DLQ/Replay, Database/Redis, 호환성, TPS/Latency 검증을 포함한다.

## Rollout 및 Rollback

- Migration 및 Mixed-version 순서: `<단계>`
- Feature Flag/Canary/단계적 배포: `<단계 또는 n/a>`
- 성공 신호와 관찰 시간: `<Metric/임계값/시간>`
- Rollback Trigger 및 Owner: `<기준/사람>`
- Rollback/Data Reconciliation/Replay: `<안전한 절차>`

## 위험 및 작업 중단 조건

| 위험/의사결정 | Owner | Task/Release 전에 필요한 사항 |
|---|---|---|
| `<위험>` | `<사람>` | `<증적>` |

## 구현 증적

> Developer는 관찰한 사실만 기록한다. 계획에서 의미 있는 변경이 발생하면 본 문서를 `Draft`로 되돌리고 재승인을 받아야 한다.

- 변경 파일: `<경로>`
- 명령/결과: `<정확한 명령, UTC 시간, Exit/결과>`
- 계획 대비 변경사항: `<없음 또는 승인 참조>`
- 잔여 위험: `<없음 또는 Owner/처리방향>`
