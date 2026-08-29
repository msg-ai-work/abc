# 애플리케이션 보안 규칙

## 신뢰 경계

모든 외부 Identity를 Authentication하고 Tenant/Account/Resource 접근 권한을 Server-side에서 Authorization한다. 모든 API/Event Boundary에서 Type, Size, Range, Format, Encoding, Enum, Ownership을 검증한다. Message Header, Payload, Callback, Log, Operator Input은 신뢰되지 않은 입력으로 취급한다.

## Secret과 Configuration

승인된 Secret Reference와 Workload Identity를 사용한다. Source, Template, Test Fixture, Log, Exception, Build Output, Work-item Evidence에 Secret을 저장하지 않는다. Local/Test/Staging/Production Identity와 Endpoint를 분리한다. 필수 Secure Configuration이 없으면 Startup을 실패시키며 Production 또는 Insecure Default로 자동 대체하지 않는다.

## 데이터 보호

- 수집·전파 Field를 최소화하고 Message Content, Identifier, Metadata, Audit Record를 분류한다.
- 전송 구간과 저장 구간은 조직이 승인한 통제로 암호화한다. Custom Cryptography를 직접 구현하지 않는다.
- Retention, Deletion, Backup, Replay, Cache TTL, DLQ 처리 정책을 일관되게 정의한다.
- Log/Metric/Trace는 Allow-list 기반 Field와 승인된 Masking/Hashing을 사용한다. Recipient/Subscriber Identifier와 Payload는 기록하지 않는다.

## 오용 방지와 복원력

Payload Limit, Recipient Limit, Rate/Quota Control, Bounded Queue, Timeout, Backpressure, 안전한 Failure Response를 적용한다. Cross-tenant Idempotency Collision과 Enumeration을 방지한다. Privileged Configuration, Replay, Suppression, Template, Routing 변경은 민감한 내용을 저장하지 않으면서 Audit한다.

## 보안 리뷰가 필요한 변경

Authentication/Authorization, Cryptography, Personal-data Scope, External Callback, Deserialization, Tenant Isolation, Secret, Replay Tooling, Admin Endpoint 또는 Security Control 완화가 포함되면 명시적인 Security Review를 수행한다.
