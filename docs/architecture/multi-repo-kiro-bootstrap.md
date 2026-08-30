# Multi-Repository Kiro Bootstrap Architecture

## 목적
Domain Repository에서 Common Harness(`msg-ai-work/abc`)와 Local Domain Skill을 중복 복사 없이 동시에 사용한다.

## 동작 구조

```text
Domain Repository Workspace
│
├── harness.yaml
├── .kiro/agents/enterprise-messaging-<domain>.json
├── skills/**/SKILL.md                    ← Domain Owner 관리
│
└── .ai-harness/common/                   ← Bootstrap 생성 / Git 미추적
    └── msg-ai-work/abc
        ├── HARNESS.md
        ├── .kiro/steering/**/*.md
        ├── .kiro/skills/**/SKILL.md
        ├── ai/rules/*.md
        └── ai/workflows/*.md
```

Domain의 Composite Kiro Agent가 `resources`를 통해 두 영역을 함께 로드한다.

```json
{
  "resources": [
    "file://.ai-harness/common/.kiro/steering/**/*.md",
    "file://.ai-harness/common/ai/rules/*.md",
    "file://.ai-harness/common/ai/workflows/*.md",
    "skill://.ai-harness/common/.kiro/skills/**/SKILL.md",
    "skill://skills/**/SKILL.md"
  ]
}
```

Kiro 공식 Custom Agent는 `resources`에서 `file://`과 `skill://` URI 및 glob을 지원한다. Workspace Agent는 `.kiro/agents/`, Workspace Skill은 `.kiro/skills/`가 표준 위치지만 Custom Agent Resource로 상대경로 Skill도 명시적으로 제공할 수 있다.

- https://kiro.dev/docs/custom-agents/
- https://kiro.dev/docs/cli/custom-agents/configuration-reference/
- https://kiro.dev/docs/skills/
- https://kiro.dev/docs/steering/

## Bootstrap
각 Domain Repository에서 실행한다.

### Windows
```powershell
./scripts/bootstrap-harness.ps1
```

### macOS/Linux
```bash
bash scripts/bootstrap-harness.sh
```

Script는 다음을 수행한다.
1. `harness.yaml`에서 Common Harness `ref`를 읽는다.
2. `.ai-harness/common`에 `abc`를 clone/fetch 한다.
3. 지정된 Branch/Tag를 checkout 한다.
4. 필수 Common Resource와 Local Composite Agent 존재를 검증한다.

## Version 정책

### Bootstrap 단계
```yaml
ref: main
```
빠르게 Common Harness를 개선한다.

### Stable 단계
```yaml
ref: v1.0.0
```
Domain Repository가 검증된 Common Harness 버전을 고정한다.

Common Harness 버전 변경은 `harness.yaml` PR로 수행한다.

## 우선순위
Conflict가 있을 때 다음 순서를 따른다.

```text
Security / Human Gate
        ↓
Common Harness Rule / Guardrail
        ↓
Domain Skill
        ↓
Task-specific Prompt
```

Domain Skill은 Common Security/Production Guardrail을 Override할 수 없다.

## Repository별 Agent
| Repository | Kiro Agent |
|---|---|
| `abc-engine` | `enterprise-messaging-engine` |
| `abc-web` | `enterprise-messaging-web` |
| `abc-tech-support` | `enterprise-messaging-tech-support` |
| `abc-projects` | `enterprise-messaging-projects` |

## 개발자 사용 흐름
```text
git clone Domain Repo
        ↓
bootstrap-harness 실행
        ↓
Kiro Workspace Open
        ↓
enterprise-messaging-<domain> 선택
        ↓
Common Harness + Domain Skill 로드
        ↓
업무 수행
        ↓
새 경험 → Skill/Eval PR
```

## 보안
- `.ai-harness/`는 Git에 Commit하지 않는다.
- Secret, Credential, 개인정보 원문을 Skill/Eval에 저장하지 않는다.
- Production 변경/재처리/배포/Rollback은 Human Gate를 유지한다.
- 외부 또는 검증되지 않은 Skill을 Common Harness에 직접 포함하지 않는다.
