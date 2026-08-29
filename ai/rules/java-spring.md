# Java 및 Spring 규칙

## 기본 기준

저장소에 고정된 JDK, Spring Boot, Build Tool, Formatting, Architecture 기준을 따른다. 승인된 계획 없이 Framework를 Upgrade하거나 Dependency를 추가하지 않는다. 새로운 Dependency Version은 고정하고 조직의 승인 절차에 따라 출처와 License를 검증한다.

## 설계

- Controller와 Message Listener는 Transport Adapter 역할에 집중하고, Business State Transition은 Application/Domain Service에 둔다.
- Constructor Injection과 Immutable Dependency를 사용한다. Field Injection과 Global Mutable State는 피한다.
- Startup Validation이 포함된 Typed Configuration Property를 사용한다. Default 값이 Production을 가리켜서는 안 된다.
- Transport DTO/Event와 Persistence Entity를 분리한다. Trust Boundary에서 Validation하고 명시적인 Mapping을 사용한다.
- Internal Exception, Stack Trace, Database 상세정보, 민감한 Payload 일부를 외부에 노출하지 않는다.

## Transaction과 Messaging

- `@Transactional` 경계는 Database Scope가 문서화된 Public Service Operation에 둔다. 하나의 Transaction이 Kafka, Redis, HTTP, Database 전체에 걸쳐 동작한다고 가정하지 않는다.
- 긴 Database Transaction 안에서 Remote Call을 수행하지 않는다. 승인된 설계에 따라 Outbox/Inbox 또는 Compensation Pattern을 사용한다.
- Kafka Acknowledgement, Error Handler, Retry, DLQ 동작을 명시적으로 설정한다. Consumer Handler는 Idempotent하게 구현한다.
- HTTP, Database, Redis, Broker Client에 Timeout을 설정한다. 무제한 Pool, Queue, Retry, Future, Blocking Wait를 사용하지 않는다.
- Interrupt 상태를 보존하고 Exception을 Retryable/Permanent Outcome으로 분류한다. 모든 예외를 Catch 후 무시하는 방식은 사용하지 않는다.

## Logging과 Observability

Allow-list 기반 Field를 사용하는 Structured Parameterized Log를 적용한다. Request/Message Body, PII, Credential, Token, 임의 Header를 문자열 연결 또는 직렬화하여 로그에 남기지 않는다. 비동기 경계를 넘어 Correlation Context를 안전하게 전달하고 Thread-local Context는 적절히 제거한다.

## 검증

State Logic은 집중된 Unit Test를 우선하고, Serialization, Transaction, Broker/Cache/Database 동작은 Integration/Contract Test로 검증한다. Test에서 시간, ID, Retry Policy는 재현 가능하도록 결정적으로 구성한다. 자동화 Test가 Production Service에 연결되어서는 안 된다.
