---
inclusion: always
---

# Enterprise Messaging Harness Policy

## Source of truth

- Treat tracked repository content as the only durable source of truth.
- Use `docs/work-items/<work-id>/` artifacts to hand work between agents; do not rely on prior chat context.
- Prefer organization rules in `ai/rules/` over generic conventions. Record justified exceptions in the work item.
- Never invent repository state, test evidence, approval, issue context, or operational results.

## Required lifecycle

1. Requirement analysis produces `REQUIREMENT.md`.
2. Architecture produces `impact-analysis.md` and `implementation-plan.md` from an approved requirement.
3. Development begins only from an approved implementation plan.
4. Validation produces `test-report.md` with exact commands and observed results.
5. AI review produces `review-report.md`; a developer remains the final PR approver.
6. Release preparation produces `release-record.md`; a human remains the deployment approver.

## Human Gate

- Valid document states are `Draft`, `Awaiting Approval`, `Approved`, and `Rejected`.
- Agents may set only `Draft` or `Awaiting Approval`.
- Only a human may set `Approved` or `Rejected` and populate approver, timestamp, and evidence.
- If approved scope or content changes, reset the affected document to `Draft` and request reapproval.
- Never implement, merge, deploy, or claim completion when a required gate is absent.

## Change discipline

- Use a traceable work ID such as `MSG-1234` in artifact paths, branches, commits, and PRs.
- Keep changes minimal and scoped to approved acceptance criteria.
- Preserve backward compatibility unless an approved requirement explicitly allows a breaking change.
- Record assumptions, unresolved questions, rule exceptions, rollback strategy, and residual risks.
- Stop and ask for a human decision when requirements conflict, risk exceeds the approved level, or production behavior cannot be safely inferred.
