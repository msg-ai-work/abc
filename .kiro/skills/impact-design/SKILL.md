---
name: impact-design
description: 승인된 메시징 요구사항을 분석하여 영향분석과 파일 단위 구현 계획을 작성한다. 애플리케이션 코드, 계약, 스키마, 인프라를 변경하기 전에 사용한다.
metadata:
  owner: architecture
  version: "1.0"
---

# 영향분석 및 설계

승인된 `REQUIREMENT.md`가 필요하다. `templates/impact-analysis.md`와 `templates/implementation-plan.md`를 사용한다.

## 조사

1. API → Service → Persistence/Cache → Producer → Broker → Consumer → Downstream 전달 경로까지 진입점을 추적한다.
2. 기존 계약, 관례, 책임 경계, 테스트, 설정, Dashboard, Alert, Runbook, Migration을 확인한다.
3. 영향받는 파일과 컴포넌트를 근거와 함께 기록하고 직접 영향, 간접 영향, 운영 영향, 영향 없음으로 구분한다.
4. 성공과 실패 시나리오를 모델링한다. 중복, Timeout, 부분 장애, 순서 변경, Poison Message, Replay, Stale Cache, DB/Broker 불일치, Downstream Throttling을 포함한다.

## 설계

- 상태 전이, 트랜잭션 경계, 전달 보장, 멱등성 Key/Storage/TTL, Partition Key, Retry Budget, DLQ/Replay, 보상 처리를 정의한다.
- API, Event, Database, Redis, Configuration의 호환성과 Migration 순서를 정의한다.
- 데이터 분류, 권한, 안전한 로그, Audit Event, Secret 처리 방식을 정의한다.
- SLI/SLO 영향, Metric, Trace, Alert, 용량 가정, TPS/Latency 검증, Rollback Trigger를 정의한다.
- 요구사항 ID와 검증 명령에 연결된 순서 있는 파일 단위 작업을 작성한다.

## 승인 단계

계획 상태는 `Awaiting Approval`로 설정하며 스스로 승인하지 않는다. 정확성, 보안, 데이터, 호환성, 롤백에 영향을 주는 미해결 의사결정이 있으면 구현을 시작할 수 없다.
