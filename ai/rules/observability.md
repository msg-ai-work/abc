# 관측성 규칙

구현 전에 관측 가능한 결과를 먼저 정의한다. Metrics, Logs, Traces, Dashboards, Alerts는 적용 가능한 경우 Accepted, Persisted, Published, Consumed, Delivered, Failed, Expired, Retried, Duplicate-suppressed, Dead-lettered 상태를 구분할 수 있어야 한다.

## Telemetry

- Metric Label은 Low-cardinality 값을 사용한다. Message ID, Recipient, Subscriber, 자유 형식 Text, Payload를 Metric Label로 사용하지 않는다.
- Structured Log에는 승인된 Event Name, Normalized Error Code, Correlation ID, 안전한 Message Type/Version, Attempt, Duration, Outcome을 기록한다.
- Trace는 임의 Header나 민감한 Baggage 없이 검증된 Correlation/Trace Context를 전파한다.
- Sampling은 금지된 데이터를 수집하지 않으면서 Error와 드문 Critical Path를 보존하도록 구성한다.

## Alert와 SLO

단일 일시적 실패보다 사용자 영향 증상과 Error Budget 소진을 기준으로 Alert를 구성한다. Threshold, Evaluation Window, Severity, Owner, Runbook, Deduplication을 정의한다. 적용 가능한 경우 Delivery Failure, Lag/Age, Retry/DLQ 증가, Reconciliation Mismatch, Dependency Saturation, Latency를 포함한다.

## 변경 시 요구사항

중요한 동작 변경에는 Dashboard/Alert 영향, Rollout Signal, Success Window, Rollback Trigger, 운영자가 구버전과 신버전을 구분하는 방법을 명시한다. Telemetry Naming과 Retention은 기존 조직 표준을 따르며, 예외는 승인이 필요하다.
