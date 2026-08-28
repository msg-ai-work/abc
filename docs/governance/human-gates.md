# Human Gate Operating Standard

## Status transitions

`Draft → Awaiting Approval → Approved | Rejected`. AI may create content and request approval but may not perform the final transition. A human records identity, UTC timestamp, immutable version/commit, and evidence. Material edits after approval return the document to `Draft`.

## Gates

- **G1 Requirement:** accountable product/domain owner confirms problem, scope, acceptance criteria, data and risk.
- **G2 Plan:** accountable architecture/domain/security owners confirm design, compatibility, tasks, validation, migration, rollback, and exceptions.
- **G3 PR:** developer reviewer confirms code, CI, AI findings, residual risk, and protected-branch merge.
- **G4 Release:** change/release authority confirms immutable artifact, environment/window, operator, monitoring, rollback, and communication.

## Approval quality

A chat reaction, Agent statement, editable branch name, or blank template is not approval. Approval points to the exact document/commit being approved. Delegation and emergency approval follow organization policy and remain human-recorded.

## Invalidations

Reapproval is required for changed acceptance criteria, delivery semantics, API/event/schema compatibility, data classification, authorization, transaction/idempotency model, migration, rollback, significant dependency, or risk level. Typographical edits that do not change meaning may retain approval when a human records that determination.

## Enforcement layers

Templates and Agents make gates visible; `scripts/Test-Harness.ps1` validates structure; CI runs the validator; branch and environment protection enforce merge/deploy controls. Repository text alone cannot configure hosting-platform protection, so owners must verify those settings separately.
