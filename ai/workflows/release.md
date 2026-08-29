# 릴리스 및 CD 워크플로우

Harness는 Deployment 방식과 독립적인 Release Readiness Contract를 제공한다. Product Repository는 승인된 CI/CD Platform 및 Protected Environment와 이를 연계하며, Agent가 직접 Deployment를 수행하지 않는다.

## CI 계약

모든 PR에서 Pipeline은 Harness Structure, Application Build, Focused Test, API/Event Compatibility, Secret/Dependency/Security Policy, 필수 Work-item Link를 검증해야 한다. CI Identity는 Read/Test 권한만 가지며 Non-production Service를 사용한다. AI가 CI Failure를 우회해서는 안 된다.

## Artifact 계약

한 번 Build한 Immutable Artifact를 Digest 기준으로 승격하며 필요한 경우 Signing/Attestation을 적용한다. Source Commit, Dependency, Schema/Config Migration, 필요 시 SBOM/Provenance, Evidence Link를 기록한다. Environment마다 서로 다른 Binary를 다시 Build하지 않는다.

## 릴리스 준비 상태

Release Manager는 승인 및 Merge된 Code, 허용 가능한 Test 결과, 해결된 Blocking Review Finding, 실행 가능한 Rollback/Reconciliation Plan이 준비된 이후에만 `release-record.md`를 작성한다. G4에는 승인 권한자, Operator, Artifact, Environment, 작업 Window, Change Ticket을 기록한다.

## 사람/플랫폼 실행

권한 있는 Operator 또는 Protected CD Identity가 Canary/Phased Rollout을 수행하고, 정의된 Success Signal을 관찰하며, Rollback Trigger가 발생하면 Rollback을 실행한다. Production Secret은 Platform에서 해석하며 Agent에게 노출하거나 Git에 저장하지 않는다. Environment Protection, 역할 분리, Audit Log, Branch Protection은 계속 활성화 상태를 유지한다.

## 결과 기록

실행 이후 실제 Timestamp, Artifact Digest, Observation, Incident, Rollback, Evidence는 사람이 기록한다. 그 전까지 결과 상태는 `Pending operator record`로 유지하며, 생성된 Plan을 Deployment 증적으로 간주하지 않는다.
