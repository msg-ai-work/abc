# Human Gate 운영 기준

## 상태 전이

`Draft → Awaiting Approval → Approved | Rejected` 상태를 사용한다. AI는 문서를 작성하고 승인을 요청할 수 있지만 최종 승인 상태로 직접 변경할 수 없다. 사람은 승인자 식별정보, UTC 시각, 변경 불가능한 버전/Commit, 승인 증적을 기록한다. 승인 후 의미 있는 수정이 발생하면 해당 문서는 다시 `Draft` 상태로 되돌린다.

## Gate 정의

- **G1 Requirement:** 책임 있는 Product/Domain Owner가 문제, 범위, Acceptance Criteria, 데이터, 위험을 확인하고 승인한다.
- **G2 Plan:** 책임 있는 Architecture/Domain/Security Owner가 설계, 호환성, 작업 항목, 검증, Migration, Rollback, 예외사항을 확인하고 승인한다.
- **G3 PR:** 개발 Reviewer가 코드, CI 결과, AI Review 결과, 잔여 위험, Protected Branch Merge 가능 여부를 확인하고 승인한다.
- **G4 Release:** Change/Release Authority가 Immutable Artifact, 대상 Environment/작업 시간, Operator, Monitoring, Rollback, Communication 계획을 확인하고 운영 실행을 승인한다.

## 승인 품질 기준

채팅 Reaction, Agent의 승인 문구, 변경 가능한 Branch 이름, 비어 있는 Template은 승인 증적이 아니다. 승인 기록은 승인 대상 문서와 정확한 Commit을 식별할 수 있어야 한다. 위임 승인과 긴급 승인은 조직 정책을 따르며 반드시 사람이 기록한다.

## 승인 무효화 조건

다음 항목이 변경되면 재승인이 필요하다.

- Acceptance Criteria
- 메시지 전달 의미와 상태 전이
- API/Event/Schema 호환성
- 데이터 분류
- 인증/인가 방식
- Transaction/Idempotency 모델
- Migration 또는 Rollback 방식
- 주요 Dependency
- 위험 수준

의미가 변하지 않는 단순 오탈자 수정은 사람이 그 사실을 명시적으로 기록한 경우 기존 승인을 유지할 수 있다.

## 강제 적용 계층

Template과 Agent는 Gate를 명확하게 노출하고, `scripts/Test-Harness.ps1`은 구조를 검증하며, CI는 해당 Validator를 실행한다. Branch Protection과 Environment Protection은 Merge 및 Deployment 통제를 강제한다. 저장소의 문서만으로 GitHub 등 Hosting Platform의 보호 설정이 자동 구성되는 것은 아니므로 Repository Owner가 해당 설정을 별도로 확인해야 한다.
