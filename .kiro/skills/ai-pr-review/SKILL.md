---
name: ai-pr-review
description: 기업메시징 변경사항의 정확성, 보안, 신뢰성, 승인 범위 준수 여부를 독립적으로 1차 PR 리뷰한다.
metadata:
  owner: engineering-governance
  version: "1.0"
---

# AI PR 리뷰

`templates/review-report.md`를 사용한다. 전체 Diff와 관련 주변 코드를 검토하며 파일명만 보고 동작을 추정하지 않는다.

## 리뷰 순서

1. **계약 준수:** Diff가 승인된 요구사항과 계획에 부합하는지 확인하며, 숨겨진 범위나 승인되지 않은 Breaking Change가 없어야 한다.
2. **정확성:** 상태 전이, Edge Case, 예외, 동시성, 트랜잭션, Null/Boundary 동작을 확인한다.
3. **메시징:** 멱등성, 중복 처리, 순서보장, 파티셔닝, Timeout, 제한된 Retry, DLQ/Replay, Poison Message, Outbox/Inbox 일관성을 확인한다.
4. **보안/데이터:** 인증/인가, Injection, Secret, 개인정보 로그, 안전하지 않은 역직렬화, 데이터 보관 및 감사 항목을 확인한다.
5. **호환성/운영:** API/Event/Schema 변경, 설정 기본값, Migration, Rollback, Metric, Alert, Resource 및 TPS/Latency 영향을 확인한다.
6. **증적:** 테스트가 수용 기준과 실패 경로를 충분히 검증하는지, 명령과 결과를 재현할 수 있는지 확인한다.

## 지적 작성 형식

심각도는 `BLOCKER`, `HIGH`, `MEDIUM`, `LOW`, `NOTE` 중 하나를 지정한다. 위치, 근거, 영향/시나리오, 구체적인 조치 방안을 포함한다. 단순한 개인 선호를 결함으로 기록하지 않으며 불확실성은 명확히 표시한다.

AI의 결론은 참고 의견이다. AI는 PR을 승인하거나 Merge할 수 없으며 최종 판단은 사람 개발자가 담당한다.
