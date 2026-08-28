# Application Security Rules

## Trust boundaries

Authenticate every external identity and authorize tenant/account/resource access server-side. Validate type, size, range, format, encoding, enum, and ownership at every API/event boundary. Treat message headers, payloads, callbacks, logs, and operator input as untrusted.

## Secrets and configuration

Use approved secret references and workload identities. Never store secrets in source, templates, test fixtures, logs, exceptions, build output, or work-item evidence. Separate local/test/staging/production identities and endpoints. Fail startup on missing required secure configuration; never fall back to production or insecure defaults.

## Data protection

- Minimize collected and propagated fields. Classify message content, identifiers, metadata, and audit records.
- Encrypt in transit and at rest using organization-approved controls; do not implement custom cryptography.
- Define retention, deletion, backup, replay, cache TTL, and DLQ handling consistently.
- Logs/metrics/traces use allow-listed fields and masking/hashing where approved; recipient/subscriber identifiers and payloads are prohibited.

## Abuse and resilience

Apply payload limits, recipient limits, rate/quota controls, bounded queues, timeouts, backpressure, and safe failure responses. Prevent cross-tenant idempotency collisions and enumeration. Audit privileged configuration, replay, suppression, template, and routing changes without storing sensitive content.

## Review triggers

Require explicit security review for authentication/authorization, cryptography, personal-data scope, external callbacks, deserialization, tenant isolation, secrets, replay tooling, admin endpoints, or reduced controls.
