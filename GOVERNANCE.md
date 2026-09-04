# Enterprise Messaging AI Harness Governance

`msg-ai-work/abc`와 Domain Repository가 동일한 원칙으로 운영되도록 **리더 / 담당자 / Reviewer**의 책임, 변경 흐름, Human Gate와 CODEOWNERS 운영 기준을 정의합니다.

## 1. 기본 원칙

> **리더는 AI가 일하는 방법을 관리하고, 담당자는 AI가 알아야 할 업무 지식을 관리하며, Reviewer는 변경의 품질과 안전성을 검증한다.**

AI Harness의 목적은 특정 개인에게 모든 판단을 집중하는 것이 아니라, 공통 기준과 Domain 지식을 분리하고 변경 내용을 독립적으로 검토할 수 있는 구조를 만드는 것입니다.

## 2. 역할 정의

| 역할 | 핵심 책임 | 주요 대상 |
|---|---|---|
| **리더** | Common Harness 방향, Governance, Rule/Guardrail, 공통 Workflow, 고위험 변경의 최종 판단 기준 관리 | `msg-ai-work/abc` |
| **담당자** | Domain Skill, Knowledge, Runbook, Eval의 작성·개선·최신화와 변경 증적 제공 | `abc-engine`, `abc-web`, `abc-tech-support`, `abc-projects` |
| **Reviewer** | PR 변경의 기술 적합성, 품질, 보안, 운영 영향, 재사용성 및 기준 충족 여부 검증 | 모든 Repository의 PR |

### 역할 분리 원칙

- 리더가 모든 Skill을 직접 작성하지 않습니다.
- 담당자는 자신이 맡은 Domain 지식을 SSOT에 축적합니다.
- Reviewer는 가능하면 변경 작성자와 분리하여 독립적으로 검토합니다.
- Reviewer의 승인은 Production 변경 승인이나 위험 수용 승인을 대신하지 않습니다.
- AI Agent의 Review는 Human Reviewer의 승인을 대신하지 않습니다.

## 3. Repository 책임 구조

| Repository | 책임 영역 | Responsible | Review | Leader Gate |
|---|---|---|---|---|
| `msg-ai-work/abc` | Common Harness / Control Plane | 리더 | Reviewer | 공통 Rule·Guardrail·Workflow 변경 |
| `msg-ai-work/abc-engine` | Engine Domain | 담당자 | Reviewer | 공통 정책 영향 또는 고위험 운영 변경 |
| `msg-ai-work/abc-web` | Web Domain | 담당자 | Reviewer | 공통 정책 영향 또는 고위험 운영 변경 |
| `msg-ai-work/abc-tech-support` | Technical Support Domain | 담당자 | Reviewer | 공통 정책 영향 또는 고위험 운영 변경 |
| `msg-ai-work/abc-projects` | Project / SI / Migration / PoC Domain | 담당자 | Reviewer | 공통 정책 영향 또는 고위험 전환 결정 |

## 4. 표준 변경 흐름

```text
담당자 또는 리더
      ↓
Branch 생성
      ↓
변경 작성 + Evidence
      ↓
Pull Request
      ↓
Reviewer Review
      ↓
Test / Eval / CI
      ↓
필요 시 리더 판단
      ↓
main Merge
      ↓
실제 업무 결과를 Skill / Runbook / Eval로 환류
```

### 기본 원칙

- `main` 직접 변경보다 Branch → Pull Request → Review 흐름을 기본으로 합니다.
- 변경 이유, 영향 범위, 검증 결과를 PR에서 추적 가능하게 남깁니다.
- Skill 변경은 Source Code와 동일하게 Version, Review, Evaluation을 갖는 팀 자산으로 관리합니다.
- 공통 Harness 규칙을 Domain Repository에 복사하여 독자적으로 변형하지 않습니다.

## 5. Review 기준

Reviewer는 최소 다음 항목을 확인합니다.

| 검토 영역 | 확인 내용 |
|---|---|
| 정확성 | 요구사항과 실제 변경이 일치하는가 |
| 기술 적합성 | 기존 Architecture와 Domain 원칙에 맞는가 |
| 품질 | 예외·경계·회귀·재사용성을 고려했는가 |
| 보안/개인정보 | Secret, Credential, 개인정보 원문이 포함되지 않았는가 |
| 운영 영향 | 장애전파, 모니터링, 배포, 원복 영향이 검토됐는가 |
| Evidence | Test/Eval/검증 결과가 재현 가능한가 |
| Human Gate | 사람이 결정해야 할 항목을 AI가 승인한 것으로 처리하지 않았는가 |

## 6. 리더 판단이 필요한 변경

다음 변경은 Reviewer 검토만으로 종료하지 않고 필요 시 리더 판단을 거칩니다.

- Common Agent / Workflow / Rule / Guardrail 변경
- Repository 간 공통 Architecture 또는 Governance 변경
- 보안 예외 또는 개인정보 처리 기준 변경
- Production 접근·배포·재기동·데이터 변경 정책 변경
- 대규모 재처리, 트래픽 전환, Rollback 기준 변경
- 여러 Domain의 운영 방식에 영향을 주는 Breaking Change
- 명확한 기준 없이 위험을 수용해야 하는 변경

## 7. Human Gate

AI가 독단적으로 최종 결정하거나 실행하지 않는 영역입니다.

- Production 배포 승인
- 운영 서버 재기동
- 운영 DB/Data 변경
- 메시지 재처리 또는 Offset 변경
- 트래픽 전환
- 보안 예외 승인
- 위험 수용
- Go/No-Go 및 Rollback 실행 결정
- 보호 Branch의 최종 Merge 승인

**AI executes and recommends; humans review and decide.**

## 8. CODEOWNERS 운영 원칙

`CODEOWNERS`는 **업무 책임자를 선언하는 문서가 아니라 PR Review를 자동 요청하기 위한 GitHub Routing 규칙**으로 사용합니다.

따라서 역할은 다음처럼 해석합니다.

- **리더**: Governance와 공통 기준의 책임 주체
- **담당자**: 변경 작성 및 Domain 지식 관리 주체
- **Reviewer**: CODEOWNERS를 통해 자동 Review 요청을 받는 검증 주체

### Bootstrap 단계

현재 GitHub Team 구성이 확정되기 전에는 저장소 관리자인 `@choiss7`을 임시 CODEOWNER/Reviewer로 사용합니다. 이는 역할을 한 사람에게 영구적으로 집중한다는 의미가 아니라 초기 운영을 위한 Bootstrap 설정입니다.

### 목표 GitHub Team 구조

| 역할/Domain | 권장 Team 이름 |
|---|---|
| 리더 | `@msg-ai-work/leaders` |
| Common Harness Reviewer | `@msg-ai-work/harness-reviewers` |
| Engine 담당자 | `@msg-ai-work/engine-maintainers` |
| Engine Reviewer | `@msg-ai-work/engine-reviewers` |
| Web 담당자 | `@msg-ai-work/web-maintainers` |
| Web Reviewer | `@msg-ai-work/web-reviewers` |
| Technical Support 담당자 | `@msg-ai-work/tech-support-maintainers` |
| Technical Support Reviewer | `@msg-ai-work/tech-support-reviewers` |
| Projects 담당자 | `@msg-ai-work/projects-maintainers` |
| Projects Reviewer | `@msg-ai-work/projects-reviewers` |

GitHub Team이 실제 생성되고 Repository 접근 권한이 부여된 뒤 CODEOWNERS의 `@choiss7`을 해당 Reviewer Team으로 교체합니다. 존재하지 않거나 접근 권한이 없는 Team을 CODEOWNERS에 미리 선언하지 않습니다.

## 9. Skill 역할 메타데이터 표준

### Common Harness Skill

```yaml
metadata:
  responsible-role: 리더
  reviewer-role: Reviewer
```

### Domain / Project Skill

```yaml
metadata:
  responsible-role: 담당자
  reviewer-role: Reviewer
```

기존 `owner`, `owner-role`, `*-domain-owner` 표현은 신규 문서에서 사용하지 않습니다.

## 10. RACI 기준

| 업무 | 리더 | 담당자 | Reviewer |
|---|:---:|:---:|:---:|
| Common Harness Architecture | A/R | C | C |
| Rule / Guardrail | A/R | C | C |
| Domain Skill 작성 | C | A/R | C |
| Knowledge / Runbook 최신화 | C | A/R | C |
| PR 변경 검토 | C | R | A/R |
| Eval 결과 검증 | C | R | A/R |
| 고위험 정책 판단 | A | R | C |
| 운영 적용 Evidence | C | R | R |

- `A`: Accountable — 최종 책임
- `R`: Responsible — 실행 책임
- `C`: Consulted — 검토·자문

## 11. Governance 변경

이 문서 자체의 변경은 Common Harness 변경으로 간주합니다.

1. 변경 목적과 영향을 PR에 기록합니다.
2. Reviewer가 역할 충돌, 보안, 운영 영향을 검토합니다.
3. 역할/승인/Human Gate 기준이 바뀌는 경우 리더 판단을 거칩니다.
4. Domain Repository의 README/CODEOWNERS와 불일치가 생기지 않도록 함께 갱신합니다.

---

> **사람의 경험은 Skill로 남기고, 변경은 Review로 검증하며, 중요한 결정은 Human Gate에서 사람이 책임진다.**
