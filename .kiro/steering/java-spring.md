---
inclusion: fileMatch
fileMatchPattern:
  - "**/*.java"
  - "**/*.kt"
  - "**/pom.xml"
  - "**/*.gradle"
  - "**/*.gradle.kts"
  - "**/application*.yml"
  - "**/application*.yaml"
  - "**/application*.properties"
---

# Java/Spring 개발 컨텍스트

Java, Kotlin, Spring 설정 또는 JVM 빌드 파일을 조회하거나 변경할 때는 아래 저장소 규칙을 적용한다.

#[[file:ai/rules/java-spring.md]]

메시징 동작과 관련된 변경에는 `ai/rules/messaging-domain.md`, `ai/rules/kafka.md`, `ai/rules/security.md`와 승인된 Work Item 구현 계획도 함께 적용한다.
