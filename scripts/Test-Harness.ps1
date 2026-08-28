[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$Root = Split-Path -Parent $PSScriptRoot
$Failures = [System.Collections.Generic.List[string]]::new()
$Checks = 0

function Add-Failure {
    param([Parameter(Mandatory)][string]$Message)
    $script:Failures.Add($Message)
}

function Assert-File {
    param([Parameter(Mandatory)][string]$RelativePath)
    $script:Checks++
    $path = Join-Path $Root $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Add-Failure "Missing required file: $RelativePath"
        return $false
    }
    return $true
}

function Get-FrontMatter {
    param([Parameter(Mandatory)][string]$Path)
    $content = Get-Content -LiteralPath $Path -Raw
    $match = [regex]::Match($content, '\A---\r?\n(?<body>.*?)\r?\n---(?:\r?\n|\z)', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    if (-not $match.Success) { return $null }
    return $match.Groups['body'].Value
}

$requiredFiles = @(
    'HARNESS.md',
    '.kiro/steering/enterprise-harness.md',
    '.kiro/steering/security-guardrails.md',
    '.kiro/steering/messaging-domain.md',
    'ai/rules/governance.md',
    'ai/rules/messaging-domain.md',
    'ai/rules/java-spring.md',
    'ai/rules/api.md',
    'ai/rules/kafka.md',
    'ai/rules/security.md',
    'ai/rules/quality.md',
    'ai/workflows/feature.md',
    'ai/workflows/bugfix.md',
    'ai/workflows/incident.md',
    'ai/workflows/release.md',
    'templates/REQUIREMENT.md',
    'templates/impact-analysis.md',
    'templates/implementation-plan.md',
    'templates/test-report.md',
    'templates/review-report.md',
    'templates/release-record.md',
    'docs/governance/human-gates.md',
    'docs/architecture/system-context.md',
    'docs/runbook/harness-operations.md',
    '.github/workflows/harness-validation.yml'
)
foreach ($file in $requiredFiles) { [void](Assert-File $file) }

$expectedAgents = @(
    'requirement-analyst', 'architect', 'developer',
    'tester', 'reviewer', 'release-manager'
)
foreach ($agentName in $expectedAgents) {
    $relativePath = ".kiro/agents/$agentName.json"
    if (-not (Assert-File $relativePath)) { continue }

    try {
        $agent = Get-Content -LiteralPath (Join-Path $Root $relativePath) -Raw | ConvertFrom-Json
    } catch {
        Add-Failure "Invalid JSON in $relativePath`: $($_.Exception.Message)"
        continue
    }

    $script:Checks++
    if ($agent.name -ne $agentName) { Add-Failure "Agent name mismatch in $relativePath" }
    if ([string]::IsNullOrWhiteSpace([string]$agent.description)) { Add-Failure "Agent description missing in $relativePath" }
    if ([string]::IsNullOrWhiteSpace([string]$agent.prompt)) { Add-Failure "Agent prompt missing in $relativePath" }
    if ($agent.includeMcpJson -ne $false) { Add-Failure "$relativePath must set includeMcpJson to false" }
    if ($agent.includePowers -ne $false) { Add-Failure "$relativePath must set includePowers to false" }
    if (@($agent.tools) -notcontains 'read') { Add-Failure "$relativePath must include the read tool" }

    foreach ($resource in @($agent.resources)) {
        if ($resource -isnot [string]) { continue }
        if ($resource -match '^(file|skill)://(?<path>.+)$' -and $Matches.path -notmatch '[*?]') {
            $script:Checks++
            if (-not (Test-Path -LiteralPath (Join-Path $Root $Matches.path) -PathType Leaf)) {
                Add-Failure "$relativePath references missing resource: $resource"
            }
        }
    }
}

$skillDirectories = Get-ChildItem -LiteralPath (Join-Path $Root '.kiro/skills') -Directory
foreach ($directory in $skillDirectories) {
    $skillPath = Join-Path $directory.FullName 'SKILL.md'
    $script:Checks++
    if (-not (Test-Path -LiteralPath $skillPath -PathType Leaf)) {
        Add-Failure "Skill directory lacks SKILL.md: $($directory.Name)"
        continue
    }
    $frontMatter = Get-FrontMatter $skillPath
    if ($null -eq $frontMatter) {
        Add-Failure "Skill has invalid/missing frontmatter: $($directory.Name)/SKILL.md"
        continue
    }
    $nameMatch = [regex]::Match($frontMatter, '(?m)^name:\s*(?<value>[a-z0-9-]+)\s*$')
    $descriptionMatch = [regex]::Match($frontMatter, '(?m)^description:\s*(?<value>\S.+)$')
    if (-not $nameMatch.Success -or $nameMatch.Groups['value'].Value -ne $directory.Name) {
        Add-Failure "Skill name must match directory: $($directory.Name)"
    }
    if (-not $descriptionMatch.Success) { Add-Failure "Skill description missing: $($directory.Name)" }
}

$validInclusions = @('always', 'auto', 'fileMatch', 'manual')
$steeringFiles = Get-ChildItem -LiteralPath (Join-Path $Root '.kiro/steering') -Filter '*.md' -File
foreach ($file in $steeringFiles) {
    $script:Checks++
    $frontMatter = Get-FrontMatter $file.FullName
    if ($null -eq $frontMatter) {
        Add-Failure "Steering has invalid/missing frontmatter: $($file.Name)"
        continue
    }
    $inclusionMatch = [regex]::Match($frontMatter, '(?m)^inclusion:\s*(?<value>\S+)\s*$')
    if (-not $inclusionMatch.Success -or $validInclusions -notcontains $inclusionMatch.Groups['value'].Value) {
        Add-Failure "Steering inclusion is invalid: $($file.Name)"
    }
    if ($inclusionMatch.Success -and $inclusionMatch.Groups['value'].Value -eq 'auto') {
        if ($frontMatter -notmatch '(?m)^name:\s*\S+' -or $frontMatter -notmatch '(?m)^description:\s*\S+') {
            Add-Failure "Auto steering requires name and description: $($file.Name)"
        }
    }
    if ($inclusionMatch.Success -and $inclusionMatch.Groups['value'].Value -eq 'fileMatch' -and $frontMatter -notmatch '(?m)^fileMatchPattern:\s*') {
        Add-Failure "fileMatch steering requires fileMatchPattern: $($file.Name)"
    }
}

$templateNames = @(
    'REQUIREMENT.md', 'impact-analysis.md', 'implementation-plan.md',
    'test-report.md', 'review-report.md', 'release-record.md'
)
foreach ($templateName in $templateNames) {
    $path = Join-Path $Root "templates/$templateName"
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { continue }
    $content = Get-Content -LiteralPath $path -Raw
    $script:Checks++
    if ($content -notmatch '\*\*Status:\*\*\s*`Draft`') {
        Add-Failure "Template must start in Draft status: $templateName"
    }
}

$textRoots = @(
    '.github', '.kiro', 'ai', 'docs', 'scripts', 'templates'
)
$allTrackedText = @(
    Get-Item -LiteralPath (Join-Path $Root 'HARNESS.md')
    foreach ($textRoot in $textRoots) {
        Get-ChildItem -LiteralPath (Join-Path $Root $textRoot) -Recurse -File |
            Where-Object { $_.Extension -in @('.md', '.json', '.yml', '.yaml', '.ps1') }
    }
)
foreach ($file in $allTrackedText) {
    $content = Get-Content -LiteralPath $file.FullName -Raw
    if ($content -match '-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----') {
        Add-Failure "Potential private key material found: $($file.FullName.Substring($Root.Length + 1))"
    }
}

$script:Checks++
$securityText = Get-Content -LiteralPath (Join-Path $Root '.kiro/steering/security-guardrails.md') -Raw
if ($securityText -notmatch '(?i)do not access production' -or $securityText -notmatch '(?i)human.*production deployment') {
    Add-Failure 'Security steering must explicitly block Agent production access and require human deployment approval.'
}

if ($Failures.Count -gt 0) {
    Write-Host "Harness validation FAILED ($Checks checks, $($Failures.Count) failures)." -ForegroundColor Red
    foreach ($failure in $Failures) { Write-Host " - $failure" -ForegroundColor Red }
    exit 1
}

Write-Host "Harness validation PASSED ($Checks checks)." -ForegroundColor Green
Write-Host "Agents: $($expectedAgents.Count); Skills: $($skillDirectories.Count); Steering files: $($steeringFiles.Count)."
