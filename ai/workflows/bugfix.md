# 버그 수정 워크플로우

Feature Workflow와 동일한 G1~G4 Gate를 사용한다. 위험 수준에 따라 절차의 깊이는 조정할 수 있지만 승인된 예외 없이 Gate 자체를 생략하지 않는다.

1. `REQUIREMENT.md`에 실제 동작과 기대 동작, 영향도, 발생 빈도, 영향 Version, 안전한 재현 방법, 근거 Source를 작성한다. Log와 Sample에서 PII/Secret은 제거한다.
2. Fix를 제안하기 전에 최초의 잘못된 State Transition을 찾고 Root Cause와 Symptom을 구분한다. 기존 Control/Test가 왜 문제를 발견하지 못했는지 기록한다.
3. `impact-analysis.md`에는 Duplicate, Retry, Ordering, Partial Failure, Concurrency, Stale Cache, Schema/Version, Data Repair 영향을 포함한다.
4. `implementation-plan.md`에는 가장 작은 안전한 수정 범위, Regression Test, Compatibility, Migration/Repair 판단, Telemetry, Rollout, Rollback을 포함한다.
5. G1/G2 승인 후에만 구현한다. 가능하면 수정 전 실패를 재현하는 Regression Demonstration을 보존하고, 수정 후 통과함을 증명한다.
6. `test-report.md`에는 원래 Failure, 인접 Path, Replay/Duplicate 동작, 필요한 Data Reconciliation 절차를 포함하며 Synthetic/Non-production Data를 사용한다.
7. AI와 Human PR Review에서 수정이 Hidden State, Retry Storm, Data Loss, Duplicate Delivery, Observability Gap을 새로 만들지 확인한다.
8. Release Record에는 영향 Version, Repair/Replay Owner, Success Signal, Rollback 제한사항을 정의한다.

긴급 Production Incident인 경우 `incident.md`를 사용하며, 어떤 경우에도 Agent에게 Production Access를 부여하지 않는다.
