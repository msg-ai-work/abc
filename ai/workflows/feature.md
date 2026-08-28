# Feature Workflow

Use for new or changed externally observable behavior. A work item lives at `docs/work-items/<work-id>/` and advances only through evidence-backed Human Gates.

## Flow

1. **Intake — Requirement Agent**
   - Create `REQUIREMENT.md`; identify source, scope, measurable criteria, data class, message semantics, NFRs, and open decisions.
   - Human Gate G1: requirement owner sets `Approved` with evidence.
2. **Impact/design — Architect Agent**
   - Trace existing code/contracts; create `impact-analysis.md` and `implementation-plan.md`.
   - Include API/event/schema compatibility, state/transaction model, failure modes, security, observability, migration, rollback, and exact validation.
   - Human Gate G2: architecture/domain/security owners approve as applicable.
3. **Implementation — Developer Agent**
   - Work only from the approved plan on a non-protected branch. Keep changes minimal and record evidence/deviations.
   - New scope or changed semantics returns the plan to `Draft` and G2.
4. **Validation — Tester Agent**
   - Create `test-report.md`; map every AC/risk to Pass, Fail, Blocked, or Not Run with reproducible evidence.
   - A human explicitly accepts any residual risk; AI cannot waive it.
5. **Review — Reviewer Agent, then developer**
   - Create `review-report.md`; resolve BLOCKER/HIGH findings or record approved disposition.
   - Human Gate G3: developer approves PR and protected-branch merge.
6. **Release readiness — Release Manager Agent**
   - Create `release-record.md` for an immutable artifact and approved change.
   - Human Gate G4: authorized owner approves deployment; operator/platform executes it outside the Agent.

## Completion

Complete only when requirements and decisions are traceable, CI evidence is linked, PR disposition is human-recorded, release/rollback instructions are viable, and actual production outcome remains operator-recorded rather than AI-claimed.
