# Incident Workflow

This workflow supports analysis and change preparation only. AI Agents never access production, execute mitigation, copy sensitive logs, or make incident-command decisions.

## During incident

- An authorized human incident commander owns severity, communication, production access, mitigation, and recovery decisions.
- Give Agents only sanitized, minimum-necessary evidence. Replace payloads, recipients, subscriber IDs, credentials, endpoints, and tenant identifiers with safe placeholders.
- AI may organize a timeline, generate hypotheses, compare code/config, suggest non-destructive diagnostic questions, and draft operator checklists. Every claim must cite supplied evidence and confidence.
- Production commands are executed and recorded only by authorized operators under existing runbooks.

## Emergency change

Create a work item with incident ID, bounded scope, risk, acceptance signal, rollback, approver, and expiry of any exception. Use expedited human approvals only where policy allows; do not silently skip G1–G4. Implement and validate against non-production/replay-safe fixtures. Protected merge and deployment remain human/platform actions.

## After stabilization

Create or update requirement, impact, plan, test, review, release, timeline, root-cause, and corrective-action evidence. Verify data reconciliation, duplicate/loss exposure, DLQ/backlog, customer impact, control failure, and alert effectiveness. Convert temporary mitigations to approved durable changes or remove them by the recorded expiry.
