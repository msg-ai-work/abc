# Enterprise Messaging AI Harness

기업 메시징 변경을 `요구사항 → 영향 분석/설계 → 구현 → 검증 → AI 리뷰 → 릴리스`로 실행하는 Kiro-native 저장소다. Git에 커밋된 코드, 규칙, 설계, 승인 증적을 Single Source of Truth로 사용한다.

## 운영 원칙

1. **AI executes, humans decide.** AI는 분석·구현·검증·리뷰 초안을 만들고 사람은 요구사항, 구현 계획, PR merge, 운영 배포를 승인한다.
2. **문서가 Agent 간 계약이다.** Agent는 대화 기억 대신 `docs/work-items/<work-id>/`의 승인된 산출물을 입력으로 사용한다.
3. **승인은 위조할 수 없다.** Agent는 `Approved` 상태나 승인자 정보를 대신 기록하지 않는다.
4. **Production은 사람과 배포 플랫폼의 영역이다.** Agent는 production 자격 증명을 열람하거나 production 명령을 실행하지 않는다.
5. **최소 권한과 데이터 경계를 지킨다.** 저장소 밖 데이터 전송, 비밀정보 저장, 개인정보 원문 로그를 금지한다.

## 시작하기

작업 식별자는 `MSG-1234` 같은 추적 가능한 ID를 사용한다. PowerShell에서 다음과 같이 작업 계약을 만든다.

```powershell
$WorkId = "MSG-1234"
$Target = "docs/work-items/$WorkId"
New-Item -ItemType Directory -Path $Target
Get-ChildItem templates/*.md | ForEach-Object { Copy-Item $_.FullName "$Target/$($_.Name)" }
```

Kiro Agent 선택기에서 아래 순서로 Agent를 실행한다. 각 단계는 선행 문서와 Human Gate 상태를 확인한 뒤 진행한다.

| 단계 | Kiro Agent | 필수 입력 | 생성·갱신 산출물 | Human Gate |
|---|---|---|---|---|
| 1 | `requirement-analyst` | 요청, 정책 | `REQUIREMENT.md` | 요구사항 승인 |
| 2 | `architect` | 승인된 요구사항 | `impact-analysis.md`, `implementation-plan.md` | 구현 계획 승인 |
| 3 | `developer` | 승인된 계획 | 코드, 계획의 구현 증적 | 변경 검토 준비 |
| 4 | `tester` | 구현과 계획 | `test-report.md` | 미해결 위험 수용 |
| 5 | `reviewer` | diff와 검증 결과 | `review-report.md` | 개발자 PR 승인/merge |
| 6 | `release-manager` | 승인된 PR과 리뷰 | `release-record.md` | 운영 배포 승인 |

## 상태 계약

문서의 `Status`는 `Draft`, `Awaiting Approval`, `Approved`, `Rejected` 중 하나다. AI는 `Draft` 또는 `Awaiting Approval`까지만 설정한다. 사람은 승인 근거와 함께 `Approved` 또는 `Rejected`를 기록한다. 승인 후 내용이 바뀌면 상태를 `Draft`로 되돌리고 재승인한다.

## 저장소 구조

- `.kiro/agents/`: 역할과 권한이 분리된 실행 Agent
- `.kiro/skills/`: 단계별 반복 절차와 체크리스트
- `.kiro/steering/`: 항상 또는 문맥에 따라 적용되는 Kiro 정책
- `ai/rules/`: 조직·도메인·기술·품질 규칙
- `ai/workflows/`: feature, bugfix, incident, release 실행 흐름
- `docs/`: 아키텍처, ADR, 운영 정책, 실제 작업 산출물
- `templates/`: Agent 간 문서 계약 원본
- `scripts/Test-Harness.ps1`: 구조와 설정의 무의존 검증기

## 검증

```powershell
pwsh -NoProfile -File scripts/Test-Harness.ps1
```

이 검증은 Kiro Agent JSON, Skill/Steering frontmatter, 필수 계약 파일, Human Gate 및 production 차단 규칙을 확인한다. 애플리케이션 코드가 추가되면 해당 빌드·테스트 명령을 `implementation-plan.md`와 `test-report.md`에 명시한다.
