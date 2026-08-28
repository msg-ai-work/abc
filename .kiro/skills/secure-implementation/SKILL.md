---
name: secure-implementation
description: Implement a human-approved Java/Spring enterprise messaging plan with minimal scope, secure defaults, and reproducible evidence.
metadata:
  owner: engineering
  version: "1.0"
---

# Secure Implementation

## Preconditions

- `REQUIREMENT.md` and `implementation-plan.md` are `Approved` with human evidence.
- The checked-out branch is not a protected production branch.
- Required local/test dependencies use non-production endpoints and credentials.

## Procedure

1. Re-read affected code and tests before editing. Follow established architecture unless the approved plan explicitly changes it.
2. Implement tasks in plan order and preserve public API/event compatibility.
3. Keep controllers/listeners thin, business behavior explicit, transactions bounded, and blocking I/O out of uncontrolled executor threads.
4. Make retryable operations idempotent. Use explicit timeouts and bounded retries; do not nest retries across layers without a total budget.
5. Never log message bodies, recipient identifiers, secrets, tokens, arbitrary headers, or raw exceptions containing sensitive payloads.
6. Use configuration validation and safe defaults. Never embed credentials or production endpoints.
7. Run targeted finite checks after changes. Do not use watch mode or production services.
8. Record changed files, exact commands/results, implementation decisions, plan deviations, and residual risks.

## Stop conditions

Stop and request reapproval if implementation requires new scope, contract breakage, schema/destructive migration changes, weaker security, different delivery semantics, or an unplanned production dependency.
