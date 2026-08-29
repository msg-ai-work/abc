---
inclusion: always
---

# 기업메시징 AI Harness 운영 정책

## 단일 기준 정보원(Source of Truth)

- Git 저장소에 추적되는 콘텐츠만 지속적으로 신뢰할 수 있는 단일 기준 정보원으로 사용한다.
- 에이전트 간 업무 인계는 `docs/work-items/<work-id>/` 산출물을 사용하며, 이전 채팅 컨텍스트에 의존하지 않는다.
- 일반적인 관례보다 `ai/rules/`에 정의된 조직 규칙을 우선 적용한다. 예외가 필요한 경우 해당 Work Item에 근거를 기록한다.
- 저장소 상태, 테스트 증적, 승인 여부, 이슈 컨텍스트, 운영 결과를 임의로 추정하거나 만들어내지 않는다.

## 필수 업무 생명주기

1. 요구사항 분석 단계에서 `REQUIREMENT.md`를 작성한다.
2. 아키텍처 단계에서는 승인된 요구사항을 기준으로 `impact-analysis.md`와 `implementation-plan.md`를 작성한다.
3. 개발은 승인된 구현 계획을 기준으로만 시작한다.
4. 검증 단계에서는 실제 수행한 명령과 관찰된 결과를 포함한 `test-report.md`를 작성한다.
5. AI 리뷰 단계에서는 `review-report.md`를 작성하며, PR의 최종 승인자는 개발자 또는 지정된 사람으로 유지한다.
6. 릴리스 준비 단계에서는 `release-record.md`를 작성하며, 실제 배포 승인은 사람이 수행한다.

## Human Gate

- 문서 상태는 `Draft`, `Awaiting Approval`, `Approved`, `Rejected`만 사용한다.
- AI Agent는 `Draft` 또는 `Awaiting Approval` 상태만 설정할 수 있다.
- `Approved` 또는 `Rejected` 상태와 승인자, 승인 시각, 승인 근거는 사람만 입력할 수 있다.
- 승인된 범위나 내용이 변경되면 영향받는 문서를 다시 `Draft` 상태로 변경하고 재승인을 요청한다.
- 필요한 Gate 승인이 없는 상태에서는 구현, Merge, 배포를 수행하거나 완료되었다고 판단하지 않는다.

## 변경 관리 원칙

- 산출물 경로, Branch, Commit, PR에는 `MSG-1234`와 같이 추적 가능한 Work ID를 사용한다.
- 변경 범위는 승인된 Acceptance Criteria를 충족하는 최소 범위로 제한한다.
- 승인된 요구사항에서 명시적으로 Breaking Change를 허용하지 않는 한 하위 호환성을 유지한다.
- 가정 사항, 미해결 질문, 규칙 예외, Rollback 전략, 잔여 위험을 문서에 기록한다.
- 요구사항 간 충돌이 발생하거나, 위험 수준이 승인 범위를 초과하거나, 운영 환경의 동작을 안전하게 판단할 수 없는 경우 작업을 중단하고 사람의 판단을 요청한다.
