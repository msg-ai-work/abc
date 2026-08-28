# Harness Operations Runbook

## Bootstrap a work item

From the repository root:

```powershell
$WorkId = "MSG-1234"
$Target = "docs/work-items/$WorkId"
if (Test-Path $Target) { throw "Work item already exists: $Target" }
New-Item -ItemType Directory -Path $Target
Get-ChildItem templates/*.md | ForEach-Object { Copy-Item $_.FullName "$Target/$($_.Name)" }
```

Replace placeholders but retain contract sections. Keep sensitive ticket/log content out of Git; link to approved systems using non-secret references.

## Operate the stages

Select the matching Kiro Agent: `requirement-analyst`, `architect`, `developer`, `tester`, `reviewer`, then `release-manager`. Each Agent checks the prior artifact/gate and stops when approval or material facts are missing. Use feature, bugfix, or incident workflow in `ai/workflows/`.

## Validate locally

```powershell
pwsh -NoProfile -File scripts/Test-Harness.ps1
```

A failure names the missing/invalid contract. Fix the repository asset; do not disable the check. Product repositories add their finite build/test/contract/security commands to CI and the implementation plan.

## CI/CD integration

`.github/workflows/harness-validation.yml` validates this harness on PR/push with read-only repository permission. Hosting administrators separately configure required checks, CODEOWNERS/review rules, protected branches, protected environments, secret manager integration, immutable artifacts, and G4 deployment approval. No workflow in this repository deploys to production because no authorized platform/target was supplied.

## Exceptions and incidents

Record exception owner, approval, reason, scope, compensating control, expiry, and removal evidence. Never bypass production boundaries. During incidents provide Agents only sanitized evidence and let an authorized incident commander/operator own production actions.

## Maintenance

Changes to rules, Agent prompts, Skills, templates, validation, or gate definitions receive independent review. Re-run the validator and review whether existing work items need migration. Track major governance changes with an ADR.
