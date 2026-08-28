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

# Java/Spring Context

Apply the repository rules below when reading or changing Java, Kotlin, Spring configuration, or JVM build files.

#[[file:ai/rules/java-spring.md]]

For messaging behavior also apply `ai/rules/messaging-domain.md`, `ai/rules/kafka.md`, `ai/rules/security.md`, and the approved work-item plan.
