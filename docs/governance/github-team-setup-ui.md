# GitHub Organization Team / Ruleset 설정 가이드

대상 Organization: `msg-ai-work`

## 목표 Team

| Team | 담당 Repository | 권장 권한 |
|---|---|---|
| `abc-admins` | `abc` | Maintain 또는 Admin |
| `engine-owners` | `abc-engine` | Maintain |
| `web-owners` | `abc-web` | Maintain |
| `tech-support-owners` | `abc-tech-support` | Maintain |
| `project-owners` | `abc-projects` | Maintain |

각 Team은 **Primary Owner + Backup Owner** 최소 2명을 권장한다.

---

## 1. Team 생성 권한 확인

GitHub에서:

```text
Profile → Organizations → msg-ai-work → Settings
→ Member privileges → Team creation rules
```

Organization Owner만 팀 생성 권한 정책을 변경할 수 있다.

팀 생성이 제한되어 있다면 Owner 계정으로 생성한다.

---

## 2. Team 생성

Organization의 `Teams` 화면에서 `New team`을 선택하고 다음 순서로 생성한다.

```text
abc-admins
engine-owners
web-owners
tech-support-owners
project-owners
```

권장 설정:

- Team visibility: 조직 정책에 맞춰 Visible 또는 Secret
- Parent team: 초기에는 없음
- Team maintainer: 각 업무 Owner

일반 팀원은 Organization Member여야 Team에 포함할 수 있다. Outside collaborator는 Team Member로 넣을 수 없다.

---

## 3. Repository 권한 부여

각 Team의 Repository 접근 권한을 다음처럼 설정한다.

| Team | Repo | 권한 |
|---|---|---|
| abc-admins | abc | Maintain/Admin |
| engine-owners | abc-engine | Maintain |
| web-owners | abc-web | Maintain |
| tech-support-owners | abc-tech-support | Maintain |
| project-owners | abc-projects | Maintain |

일반 업무 담당자는 해당 Repo에 `Write` 권한을 주고 Owner가 Review를 담당하는 방식을 권장한다.

---

## 4. CODEOWNERS 전환

Team 생성과 Repository 권한 부여가 끝난 뒤 현재 `@choiss7` 임시 Owner를 Team 기반으로 변경한다.

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

Web / Tech Support / Projects도 동일 원칙으로 적용한다.

`harness.yaml`은 Common Harness 버전 변경과 연결되므로 Domain Owner와 `abc-admins`가 함께 검토하도록 한다.

---

## 5. main 보호 — Ruleset 권장

Repository에서:

```text
Settings → Rules → Rulesets → New ruleset → New branch ruleset
```

Target branch는 `main`으로 설정한다.

권장 Rule:

- Require a pull request before merging
- Required approvals: 1명 이상
- Require review from Code Owners
- Dismiss stale approvals when new commits are pushed
- Require status checks to pass
- Require conversation resolution
- Block force pushes
- Branch deletion 제한

GitHub Ruleset은 Branch Protection과 함께 적용될 수 있으며, 여러 규칙이 겹치면 더 엄격한 조건이 적용될 수 있으므로 기존 Rule이 있는지 먼저 확인한다.

---

## 6. Required Check 연결

Domain Repository에서는 이후 추가되는 GitHub Actions Check를 Required Status Check로 지정한다.

권장 Check 이름:

```text
domain-eval-structure
```

중앙 `abc`는 추후:

```text
harness-validation
```

을 Required Check로 적용한다.

---

## 7. 테스트 PR

설정 후 작은 문서 변경 Branch를 만들어 PR을 생성한다.

확인할 것:

1. main 직접 Push가 제한되는가
2. CODEOWNER가 자동 Reviewer로 요청되는가
3. 승인 전 Merge가 차단되는가
4. Eval Action 실패 시 Merge가 차단되는가
5. 새 Commit을 Push하면 기존 승인 상태가 정책대로 갱신되는가

---

## 완료 기준

| 점검 | 완료 |
|---|---|
| 5개 Team 생성 | [ ] |
| Primary/Backup Owner 지정 | [ ] |
| Repository 권한 연결 | [ ] |
| CODEOWNERS Team 기반 전환 | [ ] |
| main Ruleset 적용 | [ ] |
| Required Check 연결 | [ ] |
| 테스트 PR 검증 | [ ] |
