# GitHub Team / CODEOWNERS Governance

## 목표
Common Harness의 최종 책임과 Domain Knowledge의 책임을 분리한다.

## 권장 GitHub Teams

| Team | Repository | 책임 | 권장 권한 |
|---|---|---|---|
| `abc-admins` | `abc` | Agent/Workflow/Rule/Guardrail/Template | Maintain 또는 Admin |
| `engine-owners` | `abc-engine` | Engine Skill/Knowledge/Runbook/Eval | Maintain |
| `web-owners` | `abc-web` | Web Skill/Knowledge/Runbook/Eval | Maintain |
| `tech-support-owners` | `abc-tech-support` | 기술지원 Skill/Knowledge/Runbook/Eval | Maintain |
| `project-owners` | `abc-projects` | Project Skill/Knowledge/Runbook/Eval | Maintain |

일반 팀원은 자신의 업무 Repository에 Write 권한을 갖고, Owner가 PR Review를 담당하는 방식을 권장한다.

## 목표 CODEOWNERS

### abc
```text
* @msg-ai-work/abc-admins
/HARNESS.md @msg-ai-work/abc-admins
/ai/ @msg-ai-work/abc-admins
/.kiro/agents/ @msg-ai-work/abc-admins
/.kiro/steering/ @msg-ai-work/abc-admins
/templates/ @msg-ai-work/abc-admins
```

### abc-engine
```text
* @msg-ai-work/engine-owners
/harness.yaml @msg-ai-work/engine-owners @msg-ai-work/abc-admins
```

### abc-web
```text
* @msg-ai-work/web-owners
/harness.yaml @msg-ai-work/web-owners @msg-ai-work/abc-admins
```

### abc-tech-support
```text
* @msg-ai-work/tech-support-owners
/harness.yaml @msg-ai-work/tech-support-owners @msg-ai-work/abc-admins
```

### abc-projects
```text
* @msg-ai-work/project-owners
/harness.yaml @msg-ai-work/project-owners @msg-ai-work/abc-admins
```

## Branch Protection 권장

| 설정 | abc | Domain Repo |
|---|---:|---:|
| main 직접 Push 금지 | 필수 | 필수 |
| PR 필수 | 필수 | 필수 |
| 승인 수 | 1+ | 1+ |
| CODEOWNER Review | 필수 | 필수 |
| Conversation Resolution | 필수 | 필수 |
| Force Push | 금지 | 금지 |
| Required Checks | Harness/Test/Eval | Eval/Lint |
| Squash Merge | 권장 | 권장 |

## 전환 순서
1. Organization에서 위 5개 Team을 생성한다.
2. 각 Team에 최소 Primary/Backup Owner를 지정한다.
3. Team에 해당 Repository 권한을 부여한다.
4. 현재 `@choiss7` 기반 CODEOWNERS를 Team 기반으로 변경한다.
5. Branch Protection에서 Require review from Code Owners를 켠다.
6. 테스트 PR로 자동 Reviewer 지정 여부를 확인한다.

## 원칙
- 팀장은 Domain Skill의 모든 변경 승인자가 되지 않는다.
- 공통 Harness 변경은 `abc-admins`가 책임진다.
- Domain Owner는 해당 Domain 지식의 정확성과 최신성을 책임진다.
- `harness.yaml` 변경은 Common Harness 버전 변경이므로 Domain Owner와 `abc-admins`가 함께 검토한다.

> 현재 GitHub 연결 기능은 Organization Team 생성 API를 제공하지 않으므로, Team 생성 전에는 기존 `@choiss7` CODEOWNERS를 유효한 임시 설정으로 유지한다.