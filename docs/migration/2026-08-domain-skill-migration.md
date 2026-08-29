# Domain Skill Multi-Repository Migration

- Date: 2026-08-30
- Source: `msg-ai-work/abc/.kiro/skills/domains/`
- Target model: Common Harness + Domain Repository

## 목적

기존 `abc` 안에서 함께 관리하던 Domain Skill을 업무별 Repository로 분리하여 Ownership과 변경 책임을 명확히 한다.

## Migration 결과

| Domain | 기존 위치 | 신규 Repository | 신규 Core Skill | 상태 |
|---|---|---|---|---|
| Engine | `.kiro/skills/domains/engine/SKILL.md` | `msg-ai-work/abc-engine` | `skills/domain-core/SKILL.md` | 완료 |
| Web | `.kiro/skills/domains/web/SKILL.md` | `msg-ai-work/abc-web` | `skills/domain-core/SKILL.md` | 완료 |
| Technical Support | `.kiro/skills/domains/tech-support-client/SKILL.md` | `msg-ai-work/abc-tech-support` | `skills/domain-core/SKILL.md` | 완료 |
| Projects | 신규 | `msg-ai-work/abc-projects` | Project Skill Catalog | 신규 구성 |

## 신규 초기 Skill 수

| Repository | Skill 수 |
|---|---:|
| `abc-engine` | 10 |
| `abc-web` | 10 |
| `abc-tech-support` | 10 |
| `abc-projects` | 10 |
| **합계** | **40** |

## 호환성 처리

기존 `abc/.kiro/skills/domains/*/SKILL.md`는 즉시 삭제하지 않고 Deprecated Stub으로 전환했다.

이유:

1. 기존 Kiro 설정이나 문서 링크가 즉시 깨지는 것을 방지한다.
2. 사용자에게 신규 SSOT 위치를 안내한다.
3. 안정화 이후 안전하게 기존 경로를 제거할 수 있게 한다.

## SSOT 원칙

- Common Agent / Workflow / Rule / Guardrail: `msg-ai-work/abc`
- Engine 업무 지식: `msg-ai-work/abc-engine`
- Web 업무 지식: `msg-ai-work/abc-web`
- Technical Support 업무 지식: `msg-ai-work/abc-tech-support`
- Project 업무 지식: `msg-ai-work/abc-projects`

동일한 Domain Skill을 `abc`와 Domain Repository에서 이중으로 관리하지 않는다.

## 다음 단계

- Domain 담당자/Owner 확정
- GitHub Team 생성 및 CODEOWNERS 교체
- 실제 Incident/개발 사례 기반 Skill v0.2 개선
- 각 핵심 Skill별 Evaluation Case 추가
- Common Harness `v1.0.0` Tag 이후 Domain `harness.yaml` Version Pin
- 안정화 후 기존 Deprecated Domain Stub 제거 검토
