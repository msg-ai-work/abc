---
name: requirement-contract
description: 추적 가능한 기업메시징 요구사항 계약을 작성한다. 기능, 버그, 정책, 운영 변경을 설계나 구현 전에 명확히 해야 할 때 사용한다.
metadata:
  owner: governance
  version: "1.0"
---

# 요구사항 계약

`templates/REQUIREMENT.md`를 사용하고 결과는 `docs/work-items/<work-id>/REQUIREMENT.md`에 작성한다.

## 절차

1. 추적 가능한 작업 ID, 요청자, 비즈니스 목표, 영향받는 사용자/시스템, 요청 완료일을 확인한다. 모르는 값은 모름으로 표시하고 임의로 만들지 않는다.
2. 현재 동작, 목표 동작, 제약사항, 가정, 범위 제외 항목을 구분한다.
3. 각 수용 기준은 `AC-<n>` 형식으로 작성하고 Given/When/Then 또는 이에 준하는 측정 가능한 조건으로 표현한다.
4. 메시지 생명주기 상태를 정의하고 API의 성공 응답이 Validation, Persistence, Publication, Final Delivery 중 무엇을 의미하는지 명확히 한다.
5. 필요 시 API/Event 호환성, 멱등성, 순서보장, Retry, Timeout, DLQ, Transaction, Redis/Database, Observability, Privacy, Retention, TPS/Latency 요구사항을 기록한다.
6. 데이터를 분류하고 외부 시스템, 담당자, 권한, Migration 필요사항, 장애 영향을 기록한다.
7. 모든 요구사항을 근거 출처와 연결하거나 가정/미해결 질문으로 표시한다.
8. 초기 위험도를 Low/Medium/High로 평가하고 이유를 적는다. High 위험 작업은 명시적인 보안/아키텍처 리뷰가 필요하다.
9. 차단 이슈가 명확히 드러나고 수용 기준이 테스트 가능한 경우에만 `Status: Awaiting Approval`로 설정한다.

## 승인 단계

설계나 구현을 수행하지 않는다. 사람만 승인 기록을 작성하고 `Status: Approved`로 변경할 수 있다. 필요한 의사결정이 하나라도 해결되지 않았다면 `Draft` 상태를 유지한다.
