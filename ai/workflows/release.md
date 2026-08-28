# Release and CD Workflow

The harness provides a deployment-independent readiness contract. Product repositories integrate it with their approved CI/CD platform and protected environments; Agents do not deploy.

## CI contract

On every PR, the pipeline must validate harness structure, application build, focused tests, API/event compatibility, secret/dependency/security policies, and required work-item links. CI identities receive read/test permissions only and use non-production services. Failures are not bypassed by AI.

## Artifact contract

Build once and promote an immutable, signed/attested artifact by digest. Record source commit, dependencies, schema/config migrations, SBOM/provenance where required, and evidence links. Do not rebuild different bytes per environment.

## Release readiness

The Release Manager creates `release-record.md` only after approved/merged code, acceptable tests, resolved blocking review findings, and a viable rollback/reconciliation plan. G4 records authorized approver, operator, artifact, environment, window, and change ticket.

## Human/platform execution

An authorized operator or protected CD identity performs canary/phased rollout, observes defined success signals, and executes rollback when triggers fire. Production secrets are resolved by the platform and never shown to Agents or stored in Git. Environment protection, separation of duties, audit logs, and branch protection remain enabled.

## Outcome

A human records actual timestamps, artifact digest, observations, incidents, rollback, and evidence after execution. Until then, outcome is `Pending operator record`; generated plans are not deployment proof.
