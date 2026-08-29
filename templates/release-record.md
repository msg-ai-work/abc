# 릴리스 및 롤백 기록서

- **Work ID:** `<WORK-ID>`
- **Status:** `Draft`
- **Source Commit / Merge된 PR:** `<변경 불가능한 참조>`
- **Artifact Version 및 Digest:** `<변경 불가능한 식별자>`
- **대상 환경:** `<environment>`
- **Release Owner/Operator:** `<권한을 가진 사람/Platform Identity>`

## 준비 상태 증적

| Gate/증적 | 참조 | 결과 |
|---|---|---|
| G1 요구사항 | `./REQUIREMENT.md` | `<verified/pending>` |
| G2 계획 | `./implementation-plan.md` | `<verified/pending>` |
| 검증 | `./test-report.md` | `<acceptable/pending>` |
| G3 PR/Review | `./review-report.md` | `<verified/pending>` |
| Artifact/Provenance/Security | `<CI 참조>` | `<verified/pending>` |

## 변경 및 호환성

동작 변경, API/Event/Schema, Kafka Topic/Consumer, Database/Redis Migration, Config/Secret 참조, 의존성, Mixed-version 동작, 보관/삭제, 용량 영향 등을 요약한다.

## 운영자 체크리스트

- [ ] Artifact Digest와 승인 상태를 확인했다.
- [ ] Backup/Reconciliation 사전 조건을 완료했다.
- [ ] Config 및 Secret의 **참조값**이 준비되어 있으며 실제 값은 본 문서에 기록하지 않았다.
- [ ] Migration 순서와 Backward Compatibility를 확인했다.
- [ ] Dashboard, Alert, On-call, Communication, Maintenance Window가 준비됐다.
- [ ] Canary/단계적 Rollout 및 관찰 시간을 합의했다.
- [ ] Rollback 의사결정 Owner와 Operator가 준비됐다.

## Rollout, 검증 및 Rollback

- 권한을 가진 Operator 수행 절차: `<검토된 Platform/Runbook 단계; Agent는 실행하지 않음>`
- 성공 Metric/임계값/관찰 시간: `<신호>`
- Rollback Trigger: `<객관적인 임계값>`
- Rollback 절차: `<Artifact/Config/Schema 단계>`
- 데이터 Reconciliation 및 메시지 Replay 안전성: `<절차/Owner>`
- 되돌릴 수 없는 영향/제약사항: `<상세>`

## 운영 배포 승인 — G4

> AI는 승인, 배포 또는 실제 수행 결과를 직접 작성해서는 안 된다.

- **결정:** `<Pending | Approved | Rejected>`
- **승인자:** `<권한을 가진 사람>`
- **Change Ticket/Window:** `<참조/시간>`
- **시각 (UTC):** `<timestamp>`
- **증적:** `<참조>`

## 실제 수행 결과 — Operator 기록

- **Outcome:** `Pending operator record`
- **시작/종료 시각 (UTC):** `<사람이 입력>`
- **배포된 Artifact Digest:** `<사람/Platform이 입력>`
- **관찰 Metric/Incident:** `<증적>`
- **Rollback/Reconciliation 수행 여부:** `<증적 또는 none>`
- **릴리스 후 승인/종료:** `<사람 참조>`
