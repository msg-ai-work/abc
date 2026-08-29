# ADR-0001: Kiro Native · Git 기반 AI Harness

- **상태:** Accepted
- **일자:** 2026-08-28
- **의사결정 책임자:** 초기 저장소 거버넌스

## 배경

기업메시징 업무에는 요구사항, 설계, 구현, 검증, 리뷰, 릴리스 과정을 반복 가능하고 추적 가능하게 관리하는 체계가 필요하다. 긴 프롬프트와 비정형 Agent 간 대화만으로 업무를 수행하면 컨텍스트가 유실되기 쉽고, 감사가 어렵고, 사람의 승인 여부를 증명하기도 어렵다. 또한 현재 Workspace에는 외부 gstack/Superpowers 패키지가 설치되거나 특정 버전으로 고정되어 있지 않다.

## 결정

Kiro Workspace의 Agent Profile, Skill, Steering과 Git에 추적되는 Markdown Workflow를 사용한다. Git을 지속 가능한 SSOT로 사용한다. Agent 간 업무 인계는 `docs/work-items/<work-id>/` 아래의 6개 버전 관리 문서 계약을 통해 수행한다. 요구사항, 구현 계획, PR Merge, 운영 릴리스 단계에는 Human Gate를 적용한다. Agent는 상속된 MCP/Powers 없이 구성하고 운영 환경 접근과 배포 실행을 금지한다.

gstack/Superpowers의 유용한 개념인 역할 전문화, 단계별 절차, 독립 리뷰, 증적 관리, 작업 중단 조건은 선언되지 않은 외부 Runtime Dependency로 두지 않고 저장소 내부의 Native Asset으로 구현한다.

## 결과 및 영향

- 모든 업무 과정은 저장소를 기준으로 감사, 리뷰, 이동, 재현할 수 있다.
- 팀은 Rule/Template을 지속 관리하고 승인 기록을 남겨야 하므로 초기에는 프로세스 비용이 증가한다.
- Markdown 검증은 문서 구조를 검증할 뿐 조직의 실제 승인 권한이나 애플리케이션의 정확성까지 증명하지는 않는다.
- 실제 적용 저장소는 제품별 CI/CD, Schema, Branch Protection, Environment Control을 별도로 연계해야 한다.

## 검토 후 제외한 대안

- **Prompt Only Workflow:** 재현성과 지식 축적이 약하다.
- **자유 형식 Multi-Agent 대화:** 계약, 감사, 승인 의미가 명확하지 않다.
- **완전 자율 운영 배포:** 보안과 책임 경계를 위반한다.
- **버전이 고정되지 않은 외부 Harness Package:** 출처, 버전, 운영 계약이 불명확하다.
