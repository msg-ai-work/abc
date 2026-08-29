# 메시징 API 규칙

## 계약

- API 우선 또는 계약 동기화 방식의 개발을 적용한다. 코드 변경과 함께 Schema 및 호환성 영향을 추적한다.
- 조직의 기존 Naming/Versioning 규칙을 우선 적용한다. 새로운 Resource 이름은 안정적인 명사를 사용하고, Resource Model로 표현하기 어려운 동작에만 명시적인 Subresource를 사용한다.
- ISO 8601 UTC Timestamp, 문서화된 Enum, 길이 제한, 명확한 Required/Null 의미, 일관된 Pagination을 사용한다.
- 기존 Field나 Enum 값의 의미를 재사용하지 않는다. Additive Change를 우선하고, 삭제나 Type 변경은 승인된 Version/Migration 계획이 필요하다.

## 요청 접수 의미

- 성공이 Validation 완료인지, 접수 완료인지, 내구성 있게 저장된 상태인지, 최종 전달 완료인지 명확히 정의한다. 비동기 요청은 일반적으로 Operation/Message ID와 Status Resource 또는 Event를 반환한다.
- 재시도 가능한 생성 요청은 Scope, Expiry, Replay 응답, 충돌 Payload 처리 방식이 문서화된 Idempotency Key를 사용한다.
- 작업을 접수하기 전에 Content-Type, Schema, Size, Recipient 수, Authorization Scope, Rate Limit을 검증한다.

## 응답과 오류

- 일관된 HTTP Status Code와 안정적인 Error Envelope를 사용한다. Error Envelope에는 안전한 Error Code, Message, Correlation ID, 필요 시 Field Violation을 포함한다.
- Client Validation/Authentication/Authorization/Conflict/Throttling 오류와 일시적인 Server/Dependency 오류를 구분한다.
- Stack Trace, Broker/Database 이름, Topology, Credential, Recipient 정보, Message Body를 노출하지 않는다.
- 재시도 가능 여부를 문서화한다. Throttling 또는 일시적 장애 시 필요하면 `Retry-After`와 같은 제한된 재시도 가이드를 제공한다.

## 신뢰성과 보안

Server/Client Timeout, Request/Payload 제한, Authentication, Tenant/Account/Resource 단위 Authorization, Audit Event, 안전한 Rate Limiting을 정의한다. Correlation ID는 Format/Length 검증 후에만 전파하고, 유효하지 않으면 안전한 값을 새로 생성한다.
