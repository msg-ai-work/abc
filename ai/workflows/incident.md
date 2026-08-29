# 장애 대응 워크플로우

이 Workflow는 분석과 변경 준비만 지원한다. AI Agent는 Production에 접근하거나, 직접 Mitigation을 실행하거나, 민감한 Log를 복사하거나, Incident Command 의사결정을 수행하지 않는다.

## 장애 중

- 권한 있는 Human Incident Commander가 Severity, Communication, Production Access, Mitigation, Recovery 의사결정을 담당한다.
- Agent에는 Sanitized된 최소 필요 Evidence만 제공한다. Payload, Recipient, Subscriber ID, Credential, Endpoint, Tenant Identifier는 안전한 Placeholder로 대체한다.
- AI는 Timeline 정리, Hypothesis 생성, Code/Config 비교, 비파괴적 Diagnostic Question 제안, Operator Checklist 초안 작성 등을 할 수 있다. 모든 주장은 제공된 Evidence와 Confidence를 근거로 해야 한다.
- Production Command는 기존 Runbook에 따라 권한 있는 Operator만 실행하고 기록한다.

## 긴급 변경

Incident ID, 제한된 Scope, Risk, Acceptance Signal, Rollback, Approver, Exception Expiry를 포함하는 Work Item을 작성한다. 정책이 허용하는 경우에만 신속 Human Approval을 사용하며 G1~G4를 조용히 생략하지 않는다. 구현과 검증은 Non-production 또는 Replay-safe Fixture를 기준으로 수행한다. Protected Merge와 Deployment는 계속 Human/Platform Action으로 남는다.

## 안정화 이후

Requirement, Impact, Plan, Test, Review, Release, Timeline, Root Cause, Corrective Action Evidence를 새로 작성하거나 갱신한다. Data Reconciliation, Duplicate/Loss Exposure, DLQ/Backlog, Customer Impact, Control Failure, Alert Effectiveness를 확인한다. Temporary Mitigation은 승인된 Durable Change로 전환하거나 기록된 Expiry에 맞춰 제거한다.
