---
name: web-domain
summary: 기업메시징 고객/관리자 웹의 운영·개발 Skill. FE/BE, API, 인증/권한, 배포 및 웹 장애 분석에 사용한다.
owner-role: web-domain-owner
version: "0.1"
---

# 웹 도메인 Skill

## 적용 범위

- 기업메시징 고객/관리자 웹
- Frontend / Backend API
- 로그인, 인증, 권한, 세션
- 메시지 발송/조회 UI와 업무 API
- 배포, 운영점검, 웹 장애 분석
- 브라우저 호환성, 성능, 보안

## 입력

- 작업 ID / 장애 ID
- 대상 화면 또는 API
- 사용자 역할
- 재현 절차
- 환경(dev/stage/prod)
- 최근 배포/설정 변경 여부

## 판단 순서

1. FE 표시 문제인지 BE/API 문제인지 분리한다.
2. 브라우저 요청 → API Gateway/Backend → DB/외부 연계 순서로 추적한다.
3. 인증/인가/세션/권한 문제 여부를 별도 확인한다.
4. 사용자 입력 검증, 예외처리, Timeout, 재시도 영향을 확인한다.
5. 운영 장애이면 최근 배포, 설정, 인증서, 외부 연계 변경 여부를 우선 확인한다.
6. 변경 작업이면 사용자 영향, 하위 호환성, Rollback을 확인한다.

## 운영 체크리스트

- [ ] 대상 URL과 환경 확인
- [ ] 사용자 Role/권한 확인
- [ ] 브라우저 Console/Network 오류 확인
- [ ] HTTP Status / API Response 확인
- [ ] 인증·세션 만료 여부 확인
- [ ] Backend 로그와 Correlation ID 연결
- [ ] DB/외부 API 지연 여부 확인
- [ ] 최근 배포/설정 변경 확인
- [ ] 주요 사용자 경로 Smoke Test 수행

## 개발 체크리스트

- [ ] 요구사항과 화면/API 수용 기준 매핑
- [ ] 인증/인가 누락 여부 확인
- [ ] 입력값 검증과 오류 메시지 확인
- [ ] API Schema 호환성 확인
- [ ] 개인정보 노출 및 로그 마스킹 확인
- [ ] FE Unit/E2E 및 BE Unit/Integration Test 정의
- [ ] 성능 영향과 Cache 정책 확인
- [ ] 배포/Rollback 및 모니터링 항목 정의

## 산출물

- 영향분석
- 화면/API 테스트 시나리오
- 운영 장애 진단 결과
- 배포 전후 Smoke Test
- 재발방지 또는 Skill 개선 PR

## 금지사항

- 운영 사용자 개인정보나 Token 원문을 Git에 저장하지 않는다.
- AI가 운영 권한 변경, 사용자 잠금해제, DB 데이터 수정, 운영 배포를 직접 실행하지 않는다.
- 보안 검증을 생략한 상태로 완료 처리하지 않는다.
