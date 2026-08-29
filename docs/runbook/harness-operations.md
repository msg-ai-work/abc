# AI Harness 운영 Runbook

## Work Item 시작

저장소 Root에서 다음 명령을 실행한다.

```powershell
$WorkId = "MSG-1234"
$Target = "docs/work-items/$WorkId"
if (Test-Path $Target) { throw "Work item already exists: $Target" }
New-Item -ItemType Directory -Path $Target
Get-ChildItem templates/*.md | ForEach-Object { Copy-Item $_.FullName "$Target/$($_.Name)" }
```

Placeholder는 실제 작업 정보로 교체하되 문서 계약의 Section 구조는 유지한다. 민감한 Ticket/Log 내용은 Git에 저장하지 않고, Secret이 포함되지 않은 참조 정보로 승인된 시스템에 연결한다.

## 단계별 운영

작업 단계에 맞는 Kiro Agent를 선택한다.

`requirement-analyst` → `architect` → `developer` → `tester` → `reviewer` → `release-manager`

각 Agent는 이전 단계의 산출물과 Gate 상태를 확인하며, 승인 또는 필수 사실이 누락된 경우 작업을 중단한다. 업무 유형에 따라 `ai/workflows/`의 `feature`, `bugfix`, `incident` Workflow를 사용한다.

## 로컬 검증

```powershell
pwsh -NoProfile -File scripts/Test-Harness.ps1
```

검증 실패 시 누락되거나 잘못된 문서 계약이 표시된다. 검증을 비활성화하지 말고 저장소 Asset을 수정한다. 실제 Product Repository는 Build/Test/Contract/Security 검증 명령을 CI와 `implementation-plan.md`에 추가한다.

## CI/CD 연계

`.github/workflows/harness-validation.yml`은 PR/Push 시 읽기 전용 Repository 권한으로 Harness 구조를 검증한다. Hosting Administrator는 별도로 Required Check, CODEOWNERS/Review Rule, Protected Branch, Protected Environment, Secret Manager 연계, Immutable Artifact, G4 Deployment Approval을 구성한다.

이 저장소에는 승인된 운영 Platform/Target 정보가 없으므로 어떤 Workflow도 Production Deployment를 직접 실행하지 않는다.

## 예외 및 장애 대응

예외가 필요한 경우 다음 내용을 기록한다.

- 예외 Owner
- 승인자
- 사유
- 적용 범위
- 보완 통제
- 만료일
- 예외 제거 증적

운영 환경 경계를 우회하지 않는다. 장애 상황에서는 Agent에 비식별·최소 필요 증적만 제공하며 실제 Production 조치는 권한 있는 Incident Commander 또는 Operator가 수행한다.

## 유지관리

Rule, Agent Prompt, Skill, Template, Validation, Gate 정의 변경은 독립적인 Review를 받아야 한다. 변경 후 Validator를 다시 실행하고 기존 Work Item의 Migration 필요 여부를 검토한다. 중요한 Governance 변경은 ADR로 기록한다.
