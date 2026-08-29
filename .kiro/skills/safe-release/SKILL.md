---
name: safe-release
description: 운영 배포를 직접 실행하지 않고 감사 가능한 기업메시징 릴리스 및 롤백 기록을 준비한다.
metadata:
  owner: release-management
  version: "1.0"
---

# 안전한 릴리스 준비

`templates/release-record.md`를 사용한다.

## 사전 조건

변경 불가능한 Artifact/Version, Merge된 PR, 승인된 요구사항과 계획, 수용 가능한 테스트 보고서, 해결된 차단 리뷰 항목, Migration 검토, Rollback 가능성, 명시된 사람의 릴리스 승인을 확인한다. 필요한 증적이 없으면 릴리스 준비 완료로 판단하지 않는다.

## 기록 항목

- Artifact Digest/Version, Source Commit, Dependency/Configuration/Secret Reference 변경사항
- API/Event/Database/Redis/Kafka 호환성과 Rollout 순서
- 배포 전 Backup/점검 항목과 권한 있는 운영자의 실행 절차
- Canary/단계적 배포, Dashboard, Alert Threshold, 성공 판단 구간, 담당자
- Rollback Trigger, 의사결정 담당자, 운영자 수행 절차, 데이터 정합성 확인, Replay 안전성
- 커뮤니케이션, 작업 시간대, Incident Escalation, 릴리스 후 검증
- CI, 승인, 변경 Ticket, 이후 운영자가 기록하는 실제 결과 링크

## 경계

운영 환경에 접속하거나 배포/롤백 명령을 직접 실행하지 않는다. 명령은 권한 있는 운영자가 검토 후 실행할 수 있는 지침으로만 준비한다. 실제 결과는 사람이 증적을 제공하기 전까지 `Pending operator record` 상태로 유지한다.
