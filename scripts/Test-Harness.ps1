<#
.SYNOPSIS
    AI Harness 저장소 구조와 핵심 운영 규칙이 정상적으로 유지되고 있는지 검증하는 스크립트이다.

.DESCRIPTION
    이 스크립트는 AI Harness가 동작하기 위해 반드시 필요한 파일, Agent 설정, Skill/Steering 메타데이터,
    문서 Template 초기 상태, 보안 가드레일 등을 자동 점검한다.

    주요 검증 범위는 다음과 같다.

    1. Harness 운영에 필요한 필수 파일이 존재하는지 확인
    2. Kiro Agent JSON 파일의 형식과 필수 속성 검증
    3. Agent가 참조하는 file://, skill:// 리소스가 실제로 존재하는지 확인
    4. Skill 디렉터리에 SKILL.md가 존재하고 Front Matter가 올바른지 검증
    5. Steering 문서의 inclusion 정책과 필수 메타데이터 검증
    6. Work Item Template이 항상 Draft 상태에서 시작하는지 확인
    7. 저장소 내 Markdown/JSON/YAML/PowerShell 파일에 Private Key가 포함되지 않았는지 점검
    8. Security Steering 문서에 운영환경 직접 접근 금지 및 사람 승인 원칙이 명시되어 있는지 확인

    이 스크립트의 목적은 "문서가 존재한다"는 사실만 확인하는 것이 아니라,
    AI Harness의 최소 거버넌스 계약이 Git 저장소 안에서 지속적으로 지켜지는지 CI에서 검증하는 것이다.

    검증 실패 시 Exit Code 1을 반환하므로 GitHub Actions 등 CI Pipeline에서 Merge 차단 조건으로 사용할 수 있다.

.NOTES
    - 운영 시스템에는 접근하지 않는다.
    - 파일 내용의 구조 및 정책 문구만 검증한다.
    - 실제 사람의 승인 여부나 조직 권한 자체를 대신 검증하지는 않는다.
    - 조직 정책 변경 시 이 스크립트의 검증 조건도 함께 변경되어야 한다.
#>

# PowerShell 고급 함수/스크립트 기능을 활성화한다.
# 현재 별도 Parameter는 없지만 향후 -Verbose 등의 공통 옵션 사용과 확장을 고려해 유지한다.
[CmdletBinding()]
param()

# 오류 발생 시 가능한 한 즉시 실행을 중단하도록 설정한다.
# 파일 읽기나 JSON 변환 중 예상하지 못한 오류를 조용히 무시하지 않기 위한 안전장치이다.
$ErrorActionPreference = 'Stop'

# 선언되지 않은 변수 사용 등 잠재적인 PowerShell 오류를 조기에 발견한다.
Set-StrictMode -Version Latest

# -----------------------------------------------------------------------------
# 공통 실행 상태 초기화
# -----------------------------------------------------------------------------

# $PSScriptRoot는 현재 스크립트가 위치한 scripts 디렉터리이다.
# 저장소 Root는 scripts의 상위 디렉터리이므로 한 단계 위 경로를 Harness Root로 사용한다.
$Root = Split-Path -Parent $PSScriptRoot

# 모든 검증 실패 메시지를 누적하는 List이다.
# 첫 오류에서 즉시 종료하지 않고 가능한 검증을 계속 수행하여 한 번에 여러 문제를 보여주기 위해 사용한다.
$Failures = [System.Collections.Generic.List[string]]::new()

# 총 검증 횟수를 기록한다.
# 마지막 결과에 "몇 개의 검증을 수행했는지" 표시하기 위한 통계값이다.
$Checks = 0

# -----------------------------------------------------------------------------
# 공통 함수: 실패 메시지 등록
# -----------------------------------------------------------------------------
function Add-Failure {
    param(
        # 검증 실패 원인을 설명하는 메시지.
        [Parameter(Mandatory)][string]$Message
    )

    # 함수 Scope가 아니라 Script 전체에서 사용하는 Failures List에 추가한다.
    $script:Failures.Add($Message)
}

# -----------------------------------------------------------------------------
# 공통 함수: 필수 파일 존재 여부 검증
# -----------------------------------------------------------------------------
function Assert-File {
    param(
        # 저장소 Root 기준 상대 경로.
        [Parameter(Mandatory)][string]$RelativePath
    )

    # 이 파일 존재 여부 검사를 1건의 Check로 집계한다.
    $script:Checks++

    # 저장소 Root와 상대 경로를 결합하여 실제 파일 경로를 만든다.
    $path = Join-Path $Root $RelativePath

    # Leaf는 "파일"인지 검사한다. 같은 이름의 디렉터리가 있어도 통과시키지 않는다.
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        Add-Failure "Missing required file: $RelativePath"
        return $false
    }

    return $true
}

# -----------------------------------------------------------------------------
# 공통 함수: Markdown Front Matter 추출
# -----------------------------------------------------------------------------
function Get-FrontMatter {
    param(
        # Front Matter를 읽을 Markdown 파일의 절대 경로.
        [Parameter(Mandatory)][string]$Path
    )

    # 파일 전체를 하나의 문자열로 읽는다.
    $content = Get-Content -LiteralPath $Path -Raw

    # 문서 맨 앞의 아래 형태를 추출한다.
    # ---
    # key: value
    # ---
    #
    # \r?\n을 사용하여 Windows(CRLF)와 Linux(LF) 줄바꿈을 모두 지원한다.
    # Singleline 옵션은 .*가 여러 줄을 포함하도록 한다.
    $match = [regex]::Match(
        $content,
        '\A---\r?\n(?<body>.*?)\r?\n---(?:\r?\n|\z)',
        [System.Text.RegularExpressions.RegexOptions]::Singleline
    )

    # Front Matter 형식을 찾지 못하면 null을 반환한다.
    if (-not $match.Success) { return $null }

    # 시작/종료 구분자인 ---를 제외하고 내부 내용만 반환한다.
    return $match.Groups['body'].Value
}

# =============================================================================
# 1. Harness 필수 파일 검증
# =============================================================================
#
# AI Harness가 팀 표준으로 동작하려면 공통 정책, Workflow, Template, Governance,
# Architecture, Runbook, CI Validator 파일이 반드시 저장소에 존재해야 한다.
# 아래 배열은 Harness의 "최소 구성 계약"이다.
#
# 신규 Rule/Workflow를 Harness 필수 구성으로 승격할 경우 이 목록에도 추가해야 한다.
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

# 각 필수 파일의 존재 여부를 검사한다.
# 반환값 자체는 사용하지 않지만 Assert-File 내부에서 실패 내역과 Check 수가 기록된다.
foreach ($file in $requiredFiles) {
    [void](Assert-File $file)
}

# =============================================================================
# 2. Kiro Agent 설정 검증
# =============================================================================
#
# Harness 표준 Lifecycle을 구성하는 6개 Agent가 모두 존재해야 한다.
# Agent 이름은 JSON의 name 값과 디렉터리/파일명 계약에 사용되므로 임의로 번역하거나 변경하지 않는다.
$expectedAgents = @(
    'requirement-analyst',
    'architect',
    'developer',
    'tester',
    'reviewer',
    'release-manager'
)

foreach ($agentName in $expectedAgents) {
    # Agent 파일 경로 규칙: .kiro/agents/<agent-name>.json
    $relativePath = ".kiro/agents/$agentName.json"

    # 파일이 없으면 이미 실패로 기록되므로 다음 Agent로 진행한다.
    if (-not (Assert-File $relativePath)) { continue }

    # -------------------------------------------------------------------------
    # 2-1. JSON 문법 검증
    # -------------------------------------------------------------------------
    try {
        # JSON 전체를 문자열로 읽은 뒤 PowerShell Object로 변환한다.
        # JSON 문법이 잘못되면 ConvertFrom-Json에서 Exception이 발생한다.
        $agent = Get-Content -LiteralPath (Join-Path $Root $relativePath) -Raw | ConvertFrom-Json
    }
    catch {
        Add-Failure "Invalid JSON in $relativePath`: $($_.Exception.Message)"
        continue
    }

    # Agent 설정 내용 자체에 대한 검증을 시작한다.
    $script:Checks++

    # 파일명과 JSON 내부 name 값이 동일해야 한다.
    # 예: developer.json 내부 name은 반드시 developer여야 한다.
    if ($agent.name -ne $agentName) {
        Add-Failure "Agent name mismatch in $relativePath"
    }

    # 사람이 Agent 역할을 이해할 수 있도록 description은 필수이다.
    if ([string]::IsNullOrWhiteSpace([string]$agent.description)) {
        Add-Failure "Agent description missing in $relativePath"
    }

    # Agent가 실제 어떤 행동을 해야 하는지 정의하는 prompt는 필수이다.
    if ([string]::IsNullOrWhiteSpace([string]$agent.prompt)) {
        Add-Failure "Agent prompt missing in $relativePath"
    }

    # 외부 MCP 설정을 자동 상속하지 않도록 강제한다.
    # 선언되지 않은 외부 데이터 경로나 Tool이 Agent에 주입되는 것을 방지하기 위한 Guardrail이다.
    if ($agent.includeMcpJson -ne $false) {
        Add-Failure "$relativePath must set includeMcpJson to false"
    }

    # 설치된 Power를 자동 상속하지 않도록 강제한다.
    # Harness가 Git에 선언된 리소스를 기준으로 재현 가능하게 동작하도록 하기 위한 조건이다.
    if ($agent.includePowers -ne $false) {
        Add-Failure "$relativePath must set includePowers to false"
    }

    # 모든 Agent는 최소한 저장소 내용을 읽을 수 있어야 하므로 read Tool을 필수로 요구한다.
    if (@($agent.tools) -notcontains 'read') {
        Add-Failure "$relativePath must include the read tool"
    }

    # -------------------------------------------------------------------------
    # 2-2. Agent가 참조하는 Repository Resource 검증
    # -------------------------------------------------------------------------
    foreach ($resource in @($agent.resources)) {
        # 문자열이 아닌 Resource 값은 이 검증에서 제외한다.
        if ($resource -isnot [string]) { continue }

        # file:// 또는 skill:// 형식의 로컬 Repository Resource만 검사한다.
        # * 또는 ? Wildcard가 포함된 경로는 여러 파일을 의미하므로 개별 파일 존재 검사를 생략한다.
        if ($resource -match '^(file|skill)://(?<path>.+)$' -and $Matches.path -notmatch '[*?]') {
            $script:Checks++

            # 실제 파일이 존재하지 않으면 Agent 실행 시 참조 오류가 발생할 수 있으므로 실패 처리한다.
            if (-not (Test-Path -LiteralPath (Join-Path $Root $Matches.path) -PathType Leaf)) {
                Add-Failure "$relativePath references missing resource: $resource"
            }
        }
    }
}

# =============================================================================
# 3. Kiro Skill 구조 및 Front Matter 검증
# =============================================================================
#
# .kiro/skills 바로 아래의 각 디렉터리는 독립적인 Skill로 간주한다.
# 각 Skill 디렉터리는 반드시 SKILL.md를 가져야 하며, SKILL.md의 Front Matter에
# name과 description이 정의되어 있어야 한다.
$skillDirectories = Get-ChildItem -LiteralPath (Join-Path $Root '.kiro/skills') -Directory

foreach ($directory in $skillDirectories) {
    # 표준 Skill 문서 경로: <skill-directory>/SKILL.md
    $skillPath = Join-Path $directory.FullName 'SKILL.md'

    $script:Checks++

    # Skill 디렉터리만 있고 SKILL.md가 없는 상태를 허용하지 않는다.
    if (-not (Test-Path -LiteralPath $skillPath -PathType Leaf)) {
        Add-Failure "Skill directory lacks SKILL.md: $($directory.Name)"
        continue
    }

    # SKILL.md의 YAML 형태 Front Matter를 추출한다.
    $frontMatter = Get-FrontMatter $skillPath

    if ($null -eq $frontMatter) {
        Add-Failure "Skill has invalid/missing frontmatter: $($directory.Name)/SKILL.md"
        continue
    }

    # name은 영문 소문자/숫자/하이픈으로 구성된 식별자여야 한다.
    $nameMatch = [regex]::Match(
        $frontMatter,
        '(?m)^name:\s*(?<value>[a-z0-9-]+)\s*$'
    )

    # description은 공백이 아닌 실제 설명 값이 존재해야 한다.
    $descriptionMatch = [regex]::Match(
        $frontMatter,
        '(?m)^description:\s*(?<value>\S.+)$'
    )

    # Skill name과 실제 디렉터리 이름이 다르면 Kiro에서 관리/참조가 혼란스러워질 수 있으므로 실패한다.
    if (-not $nameMatch.Success -or $nameMatch.Groups['value'].Value -ne $directory.Name) {
        Add-Failure "Skill name must match directory: $($directory.Name)"
    }

    # Skill 설명이 없으면 사람이 Skill 용도를 이해하기 어렵기 때문에 필수로 요구한다.
    if (-not $descriptionMatch.Success) {
        Add-Failure "Skill description missing: $($directory.Name)"
    }
}

# =============================================================================
# 4. Kiro Steering 문서 Front Matter 검증
# =============================================================================
#
# Steering은 Kiro가 어떤 상황에 특정 규칙 문서를 적용할지 결정한다.
# inclusion 값은 Kiro가 지원하는 아래 4개 값만 허용한다.
$validInclusions = @(
    'always',     # 모든 상황에서 항상 적용
    'auto',       # name/description을 바탕으로 Kiro가 자동 선택
    'fileMatch',  # 특정 파일 Pattern과 일치할 때 적용
    'manual'      # 사용자가 명시적으로 선택할 때 적용
)

# .kiro/steering 하위의 모든 Markdown 파일을 검사한다.
$steeringFiles = Get-ChildItem -LiteralPath (Join-Path $Root '.kiro/steering') -Filter '*.md' -File

foreach ($file in $steeringFiles) {
    $script:Checks++

    $frontMatter = Get-FrontMatter $file.FullName

    # Steering 문서는 Front Matter가 없으면 Kiro 적용 조건을 해석할 수 없으므로 실패한다.
    if ($null -eq $frontMatter) {
        Add-Failure "Steering has invalid/missing frontmatter: $($file.Name)"
        continue
    }

    # inclusion 값을 추출한다.
    $inclusionMatch = [regex]::Match(
        $frontMatter,
        '(?m)^inclusion:\s*(?<value>\S+)\s*$'
    )

    # inclusion이 없거나 지원하지 않는 값이면 실패한다.
    if (-not $inclusionMatch.Success -or $validInclusions -notcontains $inclusionMatch.Groups['value'].Value) {
        Add-Failure "Steering inclusion is invalid: $($file.Name)"
    }

    # -------------------------------------------------------------------------
    # auto Steering 추가 조건
    # -------------------------------------------------------------------------
    # auto 방식은 Kiro가 문서의 의미를 판단해야 하므로 name과 description이 반드시 필요하다.
    if ($inclusionMatch.Success -and $inclusionMatch.Groups['value'].Value -eq 'auto') {
        if ($frontMatter -notmatch '(?m)^name:\s*\S+' -or $frontMatter -notmatch '(?m)^description:\s*\S+') {
            Add-Failure "Auto steering requires name and description: $($file.Name)"
        }
    }

    # -------------------------------------------------------------------------
    # fileMatch Steering 추가 조건
    # -------------------------------------------------------------------------
    # fileMatch 방식은 어떤 파일에 적용할지 fileMatchPattern이 반드시 정의되어야 한다.
    if (
        $inclusionMatch.Success -and
        $inclusionMatch.Groups['value'].Value -eq 'fileMatch' -and
        $frontMatter -notmatch '(?m)^fileMatchPattern:\s*'
    ) {
        Add-Failure "fileMatch steering requires fileMatchPattern: $($file.Name)"
    }
}

# =============================================================================
# 5. Work Item Template 초기 상태 검증
# =============================================================================
#
# AI가 생성하는 Requirement, Plan, Test, Review, Release 문서는 처음부터 승인 상태여서는 안 된다.
# 모든 Template은 Draft 상태에서 시작해야 하고, 이후 Human Gate를 통해 승인 상태로 변경한다.
$templateNames = @(
    'REQUIREMENT.md',
    'impact-analysis.md',
    'implementation-plan.md',
    'test-report.md',
    'review-report.md',
    'release-record.md'
)

foreach ($templateName in $templateNames) {
    $path = Join-Path $Root "templates/$templateName"

    # 앞의 Required File 검사에서 누락 여부를 이미 확인했으므로,
    # 여기서는 파일이 없을 경우 중복 실패 메시지를 만들지 않고 건너뛴다.
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { continue }

    $content = Get-Content -LiteralPath $path -Raw
    $script:Checks++

    # Markdown Template 안에 정확히 **Status:** `Draft` 형태가 있는지 확인한다.
    # AI가 승인 상태를 미리 만들어내는 것을 방지하는 Human Gate 안전장치이다.
    if ($content -notmatch '\*\*Status:\*\*\s*`Draft`') {
        Add-Failure "Template must start in Draft status: $templateName"
    }
}

# =============================================================================
# 6. 저장소 내 Private Key 노출 여부 점검
# =============================================================================
#
# Harness 관련 문서는 Git에 저장되므로 Secret이나 Private Key가 포함되어서는 안 된다.
# 이 검사는 PEM/OpenSSH 형태 Private Key Header가 텍스트 파일에 포함되었는지 빠르게 탐지한다.
#
# 주의:
# - 이것은 최소한의 정적 검사이며 완전한 Secret Scanner를 대체하지 않는다.
# - 실제 운영에서는 GitHub Secret Scanning 등 별도의 보안 기능과 함께 사용해야 한다.
$textRoots = @(
    '.github',
    '.kiro',
    'ai',
    'docs',
    'scripts',
    'templates'
)

# HARNESS.md는 Root 파일이므로 별도로 추가하고,
# 나머지는 지정된 디렉터리에서 Markdown, JSON, YAML, PowerShell 파일을 재귀적으로 수집한다.
$allTrackedText = @(
    Get-Item -LiteralPath (Join-Path $Root 'HARNESS.md')

    foreach ($textRoot in $textRoots) {
        Get-ChildItem -LiteralPath (Join-Path $Root $textRoot) -Recurse -File |
            Where-Object {
                $_.Extension -in @('.md', '.json', '.yml', '.yaml', '.ps1')
            }
    }
)

foreach ($file in $allTrackedText) {
    $content = Get-Content -LiteralPath $file.FullName -Raw

    # RSA / EC / OPENSSH Private Key Header를 탐지한다.
    if ($content -match '-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----') {
        # 저장소 Root 이후의 상대경로만 실패 메시지에 출력해 가독성을 높인다.
        Add-Failure "Potential private key material found: $($file.FullName.Substring($Root.Length + 1))"
    }
}

# =============================================================================
# 7. Security Steering 핵심 문구 검증
# =============================================================================
#
# AI Harness의 가장 중요한 보안 원칙 중 하나는 다음 두 가지이다.
#
# 1. Agent는 운영환경에 직접 접근하지 않는다.
# 2. 운영 배포는 사람의 승인과 실행을 필요로 한다.
#
# 따라서 security-guardrails.md 문서에 이 정책이 명시되어 있는지 마지막으로 확인한다.
$script:Checks++

$securityText = Get-Content -LiteralPath (
    Join-Path $Root '.kiro/steering/security-guardrails.md'
) -Raw

# 현재 검증은 기존 영문 정책 문구를 기준으로 한다.
# Security Steering 문구를 한글화하거나 정책 표현을 변경할 경우
# 이 Regular Expression도 같은 의미를 검증할 수 있도록 함께 수정해야 한다.
if (
    $securityText -notmatch '(?i)do not access production' -or
    $securityText -notmatch '(?i)human.*production deployment'
) {
    Add-Failure 'Security steering must explicitly block Agent production access and require human deployment approval.'
}

# =============================================================================
# 8. 최종 결과 출력 및 Exit Code 반환
# =============================================================================

# 한 건이라도 실패가 있으면 CI에서 실패로 인식할 수 있도록 Exit Code 1을 반환한다.
if ($Failures.Count -gt 0) {
    Write-Host "Harness validation FAILED ($Checks checks, $($Failures.Count) failures)." -ForegroundColor Red

    # 발견된 모든 실패 원인을 한 줄씩 출력한다.
    foreach ($failure in $Failures) {
        Write-Host " - $failure" -ForegroundColor Red
    }

    exit 1
}

# 모든 검증을 통과하면 성공 메시지를 출력한다.
Write-Host "Harness validation PASSED ($Checks checks)." -ForegroundColor Green

# Harness 구성 요소 수를 추가로 표시하여 현재 저장소 구조를 빠르게 확인할 수 있게 한다.
Write-Host "Agents: $($expectedAgents.Count); Skills: $($skillDirectories.Count); Steering files: $($steeringFiles.Count)."
