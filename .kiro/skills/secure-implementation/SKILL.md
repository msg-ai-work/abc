---
name: secure-implementation
description: 사람이 승인한 Java/Spring 기업메시징 구현 계획을 최소 변경 범위, 안전한 기본값, 재현 가능한 증적 원칙에 따라 구현한다.
metadata:
  owner: engineering
  version: "1.0"
---

# 안전한 구현

## 사전 조건

- `REQUIREMENT.md`와 `implementation-plan.md`가 사람의 승인 증적과 함께 `Approved` 상태여야 한다.
- 현재 체크아웃된 Branch가 보호된 운영 Branch가 아니어야 한다.
- 필요한 로컬/테스트 의존성은 비운영 Endpoint와 Credential을 사용해야 한다.

## 절차

1. 수정 전에 영향받는 코드와 테스트를 다시 확인한다. 승인된 계획에서 명시적으로 변경하지 않는 한 기존 아키텍처를 따른다.
2. 계획에 정의된 순서대로 작업하고 공개 API/Event 호환성을 유지한다.
3. Controller/Listener는 얇게 유지하고 비즈니스 동작은 명확하게 표현하며, 트랜잭션 범위를 제한하고 통제되지 않은 Executor Thread에서 Blocking I/O를 수행하지 않는다.
4. 재시도 가능한 작업은 멱등성을 보장한다. 명시적인 Timeout과 제한된 Retry를 사용하며 전체 Retry Budget 없이 계층별 재시도를 중첩하지 않는다.
5. 메시지 본문, 수신자 식별정보, Secret, Token, 임의 Header, 민감정보를 포함할 수 있는 Raw Exception을 로그에 남기지 않는다.
6. Configuration Validation과 안전한 기본값을 사용한다. Credential이나 운영 Endpoint를 코드에 직접 넣지 않는다.
7. 변경 후 대상 범위에 맞는 유한 검증을 수행한다. Watch Mode나 운영 서비스를 사용하지 않는다.
8. 변경 파일, 정확한 명령/결과, 구현 의사결정, 계획과의 차이, 잔여 위험을 기록한다.

## 작업 중단 조건

구현 과정에서 새로운 범위, 계약 파괴, Schema/파괴적 Migration 변경, 보안 약화, 다른 전달 의미, 계획에 없던 운영 의존성이 필요해지면 작업을 중단하고 재승인을 요청한다.
