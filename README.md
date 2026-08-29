# Enterprise Messaging AI Harness

기업메시징 업무를 **AI가 반복적으로 지원할 수 있는 개발·운영 체계**로 만들기 위한 Kiro 기반 AI Harness 저장소입니다.

단순히 AI에게 코드를 작성시키는 것이 목적이 아니라, 요구사항 분석부터 설계, 구현, 테스트, 리뷰, 배포 준비, 운영 대응까지의 업무 절차를 **Agent + Workflow + Rule + Skill**로 표준화하고 Git에서 함께 관리하는 것을 목표로 합니다.

> **AI를 잘 쓰는 단계를 넘어, AI가 일할 수 있는 환경을 만드는 단계로 전환한다.**

---

## 1. 왜 AI Harness인가

기업메시징 업무는 개발뿐 아니라 운영, 장애 대응, 기술지원, 배포 검증 등 반복적이지만 숙련도가 필요한 일이 많습니다.

특히 현재 업무 비중은 대략 **운영 60% : 개발 40%** 수준이므로, AI Harness는 개발 생산성만 높이는 것이 아니라 **운영 업무의 반복 판단과 점검을 구조화하여 팀 전체 생산성을 높이는 것**을 중요하게 봅니다.

기존 방식은 업무 노하우가 담당자의 경험과 기억에 많이 의존했다면, AI Harness에서는 이를 Git에 관리되는 Skill로 전환합니다.

```text
개인의 경험
   ↓
업무 절차 정리
   ↓
Domain Skill
   ↓
Git PR / Review
   ↓
main Merge
   ↓
팀의 SSOT
   ↓
AI가 반복 활용
```

---

## 2. 전체 구성

AI Harness는 크게 **공통 Harness 영역**과 **업무 Domain Skill 영역**으로 나눕니다.

```text
                       AI HARNESS
                     [팀장 관리]
                          │
          ┌───────────────┼───────────────┐
          │               │               │
        Agent          Workflow          Rule
          │               │               │
          └───────────────┼───────────────┘
                          │
                       Skill
                          │
          ┌───────────────┼────────────────┐
          │               │                │
        엔진          기술지원              웹
                     발송클라이언트
          │               │                │
       담당 팀원        담당 팀원         담당 팀원
          │               │                │
          └────── Git PR / Review ─────────┘
                          │
                         main
                          │
                         SSOT
```

### 핵심 구성요소

| 구성 | 역할 | 주요 관리 주체 |
|---|---|---|
| **Harness** | AI가 일하는 전체 구조와 실행 원칙 | 팀장 |
| **Agent** | 요구분석, 설계, 개발, 테스트, 리뷰 등 역할별 실행자 | 팀장 |
| **Workflow** | Feature, Bugfix, Incident, Release 등의 표준 흐름 | 팀장 |
| **Rule / Guardrail** | 보안, 품질, 아키텍처, 운영 제한사항 | 팀장 |
| **Domain Skill** | 엔진·기술지원·웹 업무의 실제 판단 절차와 노하우 | 담당 팀원 |
| **Human Gate** | 승인, Merge, Production 배포 등 사람의 최종 결정 | 승인권자 |
| **Git / main** | 코드·규칙·Skill·증적을 관리하는 SSOT | 팀 전체 |

---

## 3. 업무 영역

미디어로그 기업메시징 업무는 크게 다음 세 영역으로 구분합니다.

### 3.1 엔진

SMS / MMS / RCS Gateway와 메시지 처리 파이프라인을 담당합니다.

주요 Skill 대상:

- 발송 실패 원인 분석
- Kafka Lag / Consumer 상태 분석
- Retry / DLQ / 재처리 판단
- TPS / Latency / Backpressure 점검
- Redis / DB 상태 점검
- 이통사 및 외부 연계 장애 분석
- 배포 전후 엔진 점검

기본 Skill 위치:

```text
.kiro/skills/domains/engine/
```

---

### 3.2 기술지원 (발송클라이언트)

고객사에 설치되는 발송클라이언트의 설치, 설정, 연계, 장애 대응 업무를 담당합니다.

주요 Skill 대상:

- 설치 환경 점검
- OS / JDK / DB 호환성 확인
- Network / DNS / Firewall / Port 점검
- TLS / 인증 오류 분석
- 발송 요청·응답 분석
- 고객 로그 수집 및 원인 분석
- 고객 문의 답변 초안 작성
- 반복 기술지원 업무 자동화

기본 Skill 위치:

```text
.kiro/skills/domains/tech-support-client/
```

---

### 3.3 웹

기업메시징 고객 웹 및 관리자 웹의 Frontend / Backend / API 운영·개발 업무를 담당합니다.

주요 Skill 대상:

- API 장애 분석
- 인증 / 권한 / Session 문제 분석
- Browser Console / Network 점검
- Backend Exception / DB Query 분석
- 외부 연계 Timeout 분석
- FE / BE 변경 영향도 분석
- Smoke Test
- 배포 전후 서비스 점검

기본 Skill 위치:

```text
.kiro/skills/domains/web/
```

---

## 4. 팀장과 팀원의 역할

AI Harness의 핵심 운영 원칙은 **팀장이 Harness를 만들고, 팀원이 업무 Skill을 성장시키는 것**입니다.

| 구분 | 팀장 | 업무 담당 팀원 |
|---|---|---|
| Harness 구조 | 설계·변경 승인 | 의견 제시 |
| Agent | 공통 Agent 구성·관리 | 업무 적용 및 피드백 |
| Workflow | 표준 개발·운영 흐름 관리 | 실제 업무 적용 |
| Rule / Guardrail | 최종 기준 관리 | 업무 규칙 제안 |
| Domain Skill | 구조·품질 기준 승인 | **작성·개선 Owner** |
| PR Review | 공통 Harness 변경 승인 | 자신의 Domain Skill 검토 |
| Production | Human Gate 유지 | 검증 증적 제공 |

팀장이 모든 업무 Skill을 직접 만드는 구조가 아닙니다.

각 업무를 가장 잘 아는 담당자가 자신의 경험을 Skill로 정리하고, Git PR을 통해 팀의 자산으로 축적합니다.

---

## 5. AI가 수행하는 개발·운영 흐름

기본 Harness는 아래 흐름으로 동작합니다.

```text
요구사항
   ↓
요구사항 분석 Agent
   ↓
영향도 분석 / 설계 Agent
   ↓
개발 Agent
   ↓
Test / QA Agent
   ↓
AI PR Review
   ↓
사람 검토 / 승인
   ↓
배포 준비
   ↓
운영 / 모니터링 / 장애 대응
```

| 단계 | Agent / 기능 | 주요 산출물 | Human Gate |
|---|---|---|---|
| 1 | Requirement Analyst | 요구사항 / Acceptance Criteria | 요구사항 승인 |
| 2 | Architect | 영향도 분석 / 구현 계획 | 구현 계획 승인 |
| 3 | Developer | 코드 / 변경 내역 | 개발자 확인 |
| 4 | Tester | 테스트 결과 / 미검증 위험 | 잔여 위험 판단 |
| 5 | AI Reviewer | PR 1차 리뷰 | 개발자 PR 승인 |
| 6 | Release Manager | 배포 계획 / Rollback | 운영 배포 승인 |

**AI는 분석과 실행을 지원하지만 최종 승인 책임을 대신하지 않습니다.**

---

## 6. Repository 구조

```text
msg-aiharness/
│
├── README.md
├── HARNESS.md
│
├── .github/
│   ├── CODEOWNERS
│   └── workflows/
│
├── .kiro/
│   ├── agents/                  # 역할별 AI Agent
│   ├── steering/                # Kiro 공통 정책
│   └── skills/
│       ├── requirement-contract/
│       ├── impact-design/
│       ├── messaging-validation/
│       ├── ai-pr-review/
│       ├── safe-release/
│       └── domains/
│           ├── engine/
│           │   └── SKILL.md
│           ├── tech-support-client/
│           │   └── SKILL.md
│           └── web/
│               └── SKILL.md
│
├── ai/
│   ├── rules/                   # 보안·품질·기술·도메인 Rule
│   └── workflows/               # Feature/Bugfix/Incident/Release 흐름
│
├── docs/
│   ├── architecture/
│   ├── adr/
│   ├── work-items/
│   └── team-skill-governance.md
│
├── templates/                   # 요구사항·테스트·리뷰·릴리스 템플릿
└── scripts/                     # Harness 검증 Script
```

---

## 7. Domain Skill 작성 원칙

Skill은 단순 업무 설명서가 아니라 **AI가 일정한 순서로 판단하고 실행할 수 있도록 만드는 업무 절차**입니다.

각 Skill에는 최소 다음 내용을 포함합니다.

1. **적용 범위** — 언제 사용하는 Skill인지
2. **입력** — 어떤 정보가 필요한지
3. **판단 기준** — 무엇을 보고 어떤 결정을 하는지
4. **실행 절차** — 실제 확인 순서
5. **검증 방법** — 정상/비정상을 어떻게 판단하는지
6. **산출물** — 결과를 어떤 형태로 남기는지
7. **금지사항** — AI가 하면 안 되는 작업
8. **Human Gate** — 사람이 반드시 판단해야 하는 지점

### 좋은 Skill의 기준

- 실제 반복 업무에서 바로 사용할 수 있다.
- 특정 담당자의 기억에만 의존하지 않는다.
- 신규 인력도 같은 순서로 판단할 수 있다.
- 장애·개발 경험이 쌓일수록 계속 개선된다.
- AI가 실행하더라도 사람이 검증해야 할 지점이 명확하다.

---

## 8. Skill 개선 방식

업무 중 새로운 장애나 개선 사례를 발견하면 개인 경험으로 끝내지 않고 Skill에 반영합니다.

```text
실제 업무 / 장애
      ↓
원인 및 해결
      ↓
재사용 가능한 절차로 일반화
      ↓
SKILL.md 수정
      ↓
Branch
      ↓
Pull Request
      ↓
Review
      ↓
main Merge
      ↓
다음 업무부터 AI가 재사용
```

### Branch 규칙

```text
skill/<domain>/<topic>
```

예:

```text
skill/engine/kafka-lag-diagnosis
skill/tech-support-client/tls-error
skill/web/session-timeout
```

### PR 제목 예

```text
[Skill][Engine] Kafka Lag 진단 절차 개선
[Skill][TechSupport] TLS 연결 장애 진단 추가
[Skill][Web] Session Timeout 분석 절차 개선
```

---

## 9. 운영 60% : 개발 40% 반영

업무 특성을 고려해 Skill Backlog도 운영 자동화를 우선합니다.

| 구분 | 비중 | 우선 Skill |
|---|---:|---|
| **운영** | **60%** | 장애 진단, 기술지원, 반복 점검, 배포 검증, 고객 문의 |
| **개발** | **40%** | 영향도 분석, 구현, 테스트, PR Review, 품질 개선 |

AI Harness의 성공 기준은 코드 생성량이 아니라 **사람이 반복적으로 하던 판단과 작업이 얼마나 줄어들었는가**입니다.

---

## 10. Human Gate 원칙

AI는 다음 업무를 독단적으로 수행하지 않습니다.

- Production 배포 승인
- 운영 데이터 임의 수정
- 장애 위험 수용 결정
- 보안 예외 승인
- PR 최종 Merge 판단
- 고객 개인정보 / 인증정보 외부 전송

기본 원칙:

> **AI executes, humans decide.**

AI는 분석·구현·검증·리뷰 초안을 수행하고, 중요한 결정과 책임은 사람이 담당합니다.

---

## 11. Git을 SSOT로 사용

이 저장소의 `main` Branch를 AI Harness의 **Single Source of Truth**로 사용합니다.

Git에서 관리할 대상:

- Harness
- Agent
- Workflow
- Rule / Guardrail
- Domain Skill
- 요구사항
- 설계 및 ADR
- Test 결과
- PR Review 결과
- Release / Rollback 기록
- 운영 Runbook

대화 기록이나 특정 개인의 로컬 환경이 기준이 되지 않도록 합니다.

---

## 12. 권장 KPI

| 영역 | KPI 예시 |
|---|---|
| 운영 | MTTR, 반복 문의 처리시간, 수동 점검시간, 장애 재발률 |
| 개발 | 요구사항→PR Lead Time, Review Time, 재작업률, 결함 유출률 |
| Skill | 사용 횟수, 재사용률, 수정 횟수, 최신화 경과일 |
| Harness | Human Touch Time, 자동화율, Change Failure Rate |

목표는 **AI가 만든 코드의 양**이 아니라 **운영과 개발 과정에서 사람이 쓰는 시간과 반복 작업을 줄이는 것**입니다.

---

## 13. 시작하기

작업은 추적 가능한 Work ID를 기준으로 진행합니다.

예:

```text
MSG-1234
```

작업 산출물은 다음 위치를 기본으로 사용합니다.

```text
docs/work-items/MSG-1234/
```

Harness 구조와 세부 실행 방법은 [`HARNESS.md`](HARNESS.md)를 참고합니다.

팀 Skill 운영 기준은 [`docs/team-skill-governance.md`](docs/team-skill-governance.md)를 참고합니다.

---

## 방향

이 저장소는 완성된 AI 시스템을 보관하는 곳이 아니라, **팀의 업무 경험이 쌓일수록 계속 성장하는 AI 업무 시스템**을 만드는 공간입니다.

```text
Automation
    ↓
Boost
    ↓
Creation
    ↓
AI Native
```

**사람이 AI에 매번 업무를 설명하는 방식에서, 팀의 업무 방식 자체를 AI가 이해하고 실행할 수 있는 구조로 발전시키는 것이 최종 목표입니다.**
