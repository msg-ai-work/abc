---
name: engine-domain
summary: 기업메시징 엔진 업무를 위한 운영·개발 Skill. SMS/MMS/RCS GW, 큐/브로커, 발송 처리, 재처리, 성능 및 장애 분석에 사용한다.
owner-role: engine-domain-owner
version: "0.1"
---

# 엔진 도메인 Skill

## 적용 범위

- SMS/MMS/RCS Gateway 및 중계 엔진
- 메시지 수신, 라우팅, 발송, 결과 수신, 재처리
- Kafka/Queue/Redis/DB 등 상태·비동기 처리
- TPS, 지연시간, Backlog/Lag, Timeout, Retry, DLQ
- 장애 분석, 운영 점검, 배포 전후 검증

## 입력

- 작업 ID / 장애 ID
- 대상 서비스와 컴포넌트
- 요구사항 또는 장애 현상
- 영향 시간대와 환경(dev/stage/prod)
- 관련 로그·메트릭의 비민감 요약

## 판단 순서

1. 메시지 처리 흐름의 어느 단계인지 식별한다.
2. 요청량 증가인지 처리능력 저하인지 분리한다.
3. Producer → Broker → Consumer → 외부 연계 → 결과처리 순서로 병목을 좁힌다.
4. 오류율, Lag, Retry, Timeout, Connection, DB Lock/Resource 사용률을 확인한다.
5. 중복·유실·순서보장·재처리 영향 여부를 평가한다.
6. 변경 작업이면 호환성, Rollback, 용량 영향과 연계 시스템 영향을 함께 확인한다.

## 운영 체크리스트

- [ ] 현재 TPS와 평시/피크 기준 비교
- [ ] Consumer Lag / Queue Depth 확인
- [ ] 성공·실패·Timeout 비율 확인
- [ ] Retry 폭증 및 DLQ 적재 여부 확인
- [ ] CPU/Memory/GC/Thread/Connection Pool 확인
- [ ] Redis/DB Latency 및 Lock 확인
- [ ] 외부 이통사/연계 구간 지연 여부 분리
- [ ] 재기동/재처리 시 중복 발송 위험 확인
- [ ] 장애 종료 후 재발방지 항목 기록

## 개발 체크리스트

- [ ] 기존 메시지 상태 전이 영향 분석
- [ ] API/Event Schema 하위 호환성 확인
- [ ] 멱등성 및 중복 처리 확인
- [ ] Timeout/Retry/Backoff 정책 확인
- [ ] 성능 기준과 부하 테스트 범위 정의
- [ ] Rollback 가능한 변경인지 확인
- [ ] 로그/메트릭/Trace 관측성 추가 여부 확인

## 산출물

- 영향분석
- 장애 원인 후보 및 확인 근거
- 테스트 시나리오
- 배포 전후 점검표
- 재발방지 또는 Skill 개선 PR

## 금지사항

- AI가 운영 환경에서 재기동, 재처리, DB 수정, 트래픽 전환을 자동 실행하지 않는다.
- 고객 메시지 원문, 전화번호, 인증정보를 저장소에 기록하지 않는다.
- 실행하지 않은 점검을 Pass로 기록하지 않는다.
