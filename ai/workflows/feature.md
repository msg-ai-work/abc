# 기능 개발 워크플로우

외부에서 관찰 가능한 새로운 기능 또는 동작 변경에 사용한다. Work Item은 `docs/work-items/<work-id>/`에 저장하고, 증적 기반 Human Gate를 통과할 때만 다음 단계로 진행한다.

## 흐름

1. **요청 접수 — Requirement Agent**
   - `REQUIREMENT.md`를 작성하고 Source, Scope, 측정 가능한 Acceptance Criteria, Data Class, Message Semantics, NFR, 미결정 사항을 정의한다.
   - Human Gate G1: Requirement Owner가 증적과 함께 `Approved`로 승인한다.
2. **영향분석/설계 — Architect Agent**
   - 기존 Code/Contract를 추적하고 `impact-analysis.md`, `implementation-plan.md`를 작성한다.
   - API/Event/Schema Compatibility, State/Transaction Model, Failure Mode, Security, Observability, Migration, Rollback, 정확한 Validation 방법을 포함한다.
   - Human Gate G2: 필요에 따라 Architecture/Domain/Security Owner가 승인한다.
3. **구현 — Developer Agent**
   - 승인된 Plan을 기준으로 Non-protected Branch에서만 작업한다. 변경은 최소화하고 Evidence와 Deviation을 기록한다.
   - 새로운 Scope 또는 Semantics 변경이 필요하면 Plan을 `Draft`로 되돌리고 G2 승인을 다시 받는다.
4. **검증 — Tester Agent**
   - `test-report.md`를 작성하고 모든 AC/Risk를 재현 가능한 증적과 함께 Pass, Fail, Blocked, Not Run 중 하나로 연결한다.
   - Residual Risk 수용은 사람이 명시적으로 결정하며 AI가 면제할 수 없다.
5. **리뷰 — Reviewer Agent 이후 Developer**
   - `review-report.md`를 작성하고 BLOCKER/HIGH Finding을 해결하거나 승인된 처리 결과를 기록한다.
   - Human Gate G3: Developer가 PR과 Protected Branch Merge를 승인한다.
6. **릴리스 준비 — Release Manager Agent**
   - Immutable Artifact와 승인된 Change를 기준으로 `release-record.md`를 작성한다.
   - Human Gate G4: 권한 있는 Owner가 Deployment를 승인하고, 실제 실행은 Agent 외부의 Operator/Platform이 수행한다.

## 완료 기준

Requirement와 Decision이 추적 가능하고, CI Evidence가 연결되어 있으며, PR 처리 결과가 사람에 의해 기록되고, Release/Rollback 절차가 실행 가능한 상태여야 한다. 실제 Production 결과는 AI가 완료로 주장하지 않고 Operator가 기록한다.
