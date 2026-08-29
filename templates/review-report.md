# AI 1차 리뷰 보고서

- **Work ID:** `<WORK-ID>`
- **Status:** `Draft`
- **검토한 Diff/Commit:** `<변경 불가능한 참조>`
- **Reviewer:** `<AI agent/version 또는 사람>`
- **검토 시각 (UTC):** `<timestamp>`

## 권고 판단

`<BLOCK | CHANGES REQUIRED | NO BLOCKING FINDINGS>`

이 판단은 권고사항이며 PR 승인이 아니다. 최종 Review와 Merge 책임은 사람 Developer에게 있다.

## 검토 범위와 증적

- 승인된 요구사항/계획: `<참조>`
- Diff 및 주변 실행 경로: `<참조>`
- Test/CI/Security 증적: `<참조>`
- 미검토 영역/제약사항: `<명시적인 공백>`

## 발견사항

| ID | 심각도 | 위치/증적 | 실패 또는 악용 시나리오와 영향 | 필요한 조치 |
|---|---|---|---|---|
| REV-1 | `<BLOCKER/HIGH/MEDIUM/LOW/NOTE>` | `<file:line/reference>` | `<구체적인 동작>` | `<실행 가능한 수정안>` |

## Review 체크리스트

- [ ] 승인된 범위와 인수 기준을 숨은 변경 없이 충족한다.
- [ ] API/Event/Data 호환성과 Migration이 안전하다.
- [ ] 상태 전이, Transaction, Concurrency, 실패 처리가 올바르다.
- [ ] Idempotency, 중복 처리, Ordering, Timeout, Retry, DLQ, Replay가 안전하다.
- [ ] 인증, 인가, Tenant/Data 경계, Secret, Logging이 안전하다.
- [ ] Metric, Alert, Capacity, Rollout, Reconciliation, Rollback이 운영 관점에서 실행 가능하다.
- [ ] 검증 증적이 충분하고 재현 가능하다.

## 발견사항 처리 결과

| Finding | 해결 내용/증적 | AI 재확인 | 사람의 최종 판단 |
|---|---|---|---|
| `REV-1` | `<commit/test>` | `<resolved/open>` | `<pending/accepted/rejected>` |

## 사람 PR 의사결정 — G3

> AI는 승인 또는 Merge 증적을 직접 작성해서는 안 된다.

- **결정:** `<Pending | Approved | Rejected>`
- **Developer 승인자:** `<사람 식별자>`
- **시각 (UTC):** `<timestamp>`
- **PR/Merge 증적:** `<참조>`
