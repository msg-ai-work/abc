# 도메인 Skills

이 디렉터리는 미디어로그 기업메시징 업무의 실제 노하우를 AI가 재사용할 수 있는 Skill로 관리한다.

## 담당 영역

- `engine/`: 엔진 담당 팀원
- `tech-support-client/`: 기술지원(발송클라이언트) 담당 팀원
- `web/`: 웹 담당 팀원

공통 Harness 구조, Agent, Workflow, Rule, Human Gate는 팀장이 관리한다. Domain Skill의 내용은 담당 팀원이 Owner이며 PR로 개선한다.

## Skill 작성 형식

각 Skill은 최소 다음을 포함한다.

1. 적용 범위
2. 입력
3. 판단 순서
4. 운영 체크리스트
5. 개발/개선 체크리스트
6. 산출물
7. 금지사항

## 좋은 Skill의 기준

- 실제 반복 업무에서 바로 사용할 수 있다.
- 특정 담당자의 기억에만 의존하지 않는다.
- 신규 인력도 같은 순서로 판단할 수 있다.
- AI가 실행하더라도 사람이 검증해야 할 Gate가 명확하다.
- 장애/개발 경험이 쌓일수록 PR을 통해 더 좋아진다.

## Branch / PR 규칙

- Branch: `skill/<domain>/<topic>`
- 예: `skill/engine/kafka-lag-diagnosis`
- PR 제목: `[Skill][Engine] Kafka Lag 진단 절차 개선`
- PR에는 변경 이유, 적용 사례, 검증 방법, 영향 범위를 작성한다.

## Skill 확장 예시

```text
.kiro/skills/domains/
├── engine/
│   ├── SKILL.md
│   ├── kafka-lag-diagnosis/
│   │   └── SKILL.md
│   ├── send-failure-analysis/
│   │   └── SKILL.md
│   └── release-check/
│       └── SKILL.md
├── tech-support-client/
│   ├── SKILL.md
│   ├── install-diagnosis/
│   │   └── SKILL.md
│   ├── network-check/
│   │   └── SKILL.md
│   └── customer-log-analysis/
│       └── SKILL.md
└── web/
    ├── SKILL.md
    ├── api-incident-analysis/
    │   └── SKILL.md
    ├── auth-session-diagnosis/
    │   └── SKILL.md
    └── smoke-test/
        └── SKILL.md
```
