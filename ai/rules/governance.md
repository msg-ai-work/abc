# 거버넌스 및 소유권 규칙

## 운영 모델

- **Policy Authority (U+)**는 필수 Architecture, Security, Compliance, Data, API/Event, Quality, Release 기준을 소유한다.
- **Domain Execution (MediaLog)**은 승인된 정책과 요구사항을 재사용 가능한 Code, Test, Runbook, 운영 증적으로 전환한다.
- **AI Harness**는 Git에 관리되는 자산을 반복 적용하는 역할이며, 정책을 새로 만들거나 통제를 면제하거나 책임 있는 사람을 대체하지 않는다.

실제 조직의 소유권이 다르면 Work Item에 권한 있는 Owner를 명확히 기록한다. 이 문서는 Harness의 역할 모델을 정의하는 것이며, 그 자체가 조직의 승인 문서는 아니다.

## Git을 SSOT로 사용

Source, Requirement, Architecture, API/Event Schema, ADR, Rule, Skill, Test, Runbook, Approval, Review Finding, Release Evidence를 Git에서 관리한다. Git 외부에서 결정된 사항은 변경되지 않는 Reference로 연결하거나 요약 기록한다. Secret 또는 규제 대상 Payload를 증적으로 저장하지 않는다.

## 필수 Human Gate

| Gate | 필요한 사람의 의사결정 | 최소 증적 |
|---|---|---|
| G1 Requirement | Scope와 Acceptance Criteria 승인 | Approver, UTC Timestamp, Ticket/Meeting/PR Reference |
| G2 Plan | Design, Task, Validation, Rollback 승인 | Architecture/Security/Domain 의사결정 Reference |
| G3 PR | Code와 AI Review 결과 승인 | CI Evidence, 해결된 Blocker, Developer Approval |
| G4 Release | 운영 실행 승인 | Change Ticket, Artifact, 작업 Window, Operator, Rollback Owner |

AI는 사람의 승인을 대신 기록할 수 없다. 승인 이후 의미 있는 변경이 발생하면 기존 승인은 무효가 되며 문서는 다시 `Draft` 상태로 돌아가야 한다.

## 역할 분리

Implementation Author가 유일한 Reviewer가 되어서는 안 된다. AI Reviewer는 1차 검토만 수행한다. Protected Branch Merge와 Production Deployment는 권한 있는 사람 또는 Platform Identity만 수행한다. 모든 예외에는 Owner, 사유, 만료일, 보완 통제, 승인을 기록한다.

## 측정 지표

Lead Time, Human Touch Time, Escaped Defect, Rework Rate, PR Review Time, Change Failure Rate, Recovery Time을 측정한다. AI가 생성한 코드 라인 수를 주요 성공 지표로 사용하지 않는다.
