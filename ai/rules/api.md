# Messaging API Rules

## Contract

- API-first or contract-synchronized development is required. Track the schema and compatibility impact with the code change.
- Follow existing organization naming/versioning. New resource names use stable nouns; actions use explicit subresources only when no resource model fits.
- Use ISO 8601 UTC timestamps, documented enums, bounded lengths, explicit required/null semantics, and consistent pagination.
- Never repurpose a field or enum value. Additive changes are preferred; removals/type changes require an approved version/migration plan.

## Submission semantics

- Define whether success means validated, accepted, durably persisted, or delivered. Asynchronous submission normally returns an operation/message ID and a status resource/event.
- For retriable creation, require an idempotency key with documented scope, expiry, replay response, and conflicting-payload behavior.
- Validate content type, schema, size, recipient count, authorization scope, and rate limits before accepting work.

## Responses and errors

- Use consistent status codes and a stable error envelope containing a safe error code, message, correlation ID, and optional field violations.
- Separate client validation/authentication/authorization/conflict/throttling errors from transient server/dependency failures.
- Do not expose stack traces, broker/database names, topology, credentials, recipient data, or message body.
- Document retryability. For throttling or temporary unavailability, provide bounded guidance such as `Retry-After` when appropriate.

## Reliability and security

Set server and client timeouts, request/payload limits, authentication, authorization per tenant/account/resource, audit events, and safe rate limiting. Propagate correlation IDs only after format/length validation; generate a safe value otherwise.
