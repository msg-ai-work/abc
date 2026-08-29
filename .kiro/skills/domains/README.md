# Domain Skills — Migrated

기업메시징 Domain Skill은 **Multi-Repository 구조로 이전되었습니다.**

이 디렉터리는 과거 경로 호환성과 Migration 안내를 위해 당분간 유지합니다.

## 신규 SSOT

| Domain | 신규 Repository | Skill 위치 |
|---|---|---|
| Engine | `msg-ai-work/abc-engine` | `skills/` |
| Web | `msg-ai-work/abc-web` | `skills/` |
| Technical Support | `msg-ai-work/abc-tech-support` | `skills/` |
| Projects | `msg-ai-work/abc-projects` | `skills/` |

## 관리 원칙

- 신규 Domain Skill을 이 디렉터리에 추가하지 않습니다.
- 기존 Engine/Web/Tech Support Core Skill은 각 Domain Repo의 `skills/domain-core/SKILL.md`로 이관했습니다.
- 공통 Agent / Workflow / Rule / Guardrail만 `msg-ai-work/abc`에서 관리합니다.
- Domain 업무 담당자는 자신의 Repository에서 Branch → PR → Review → main 방식으로 Skill을 개선합니다.

## 기존 경로

```text
.kiro/skills/domains/
├── engine/SKILL.md                # Deprecated Stub
├── web/SKILL.md                   # Deprecated Stub
└── tech-support-client/SKILL.md   # Deprecated Stub
```

기존 경로의 파일은 새 SSOT를 안내하는 Stub이며 실제 업무 지식의 최신본으로 사용하면 안 됩니다.
