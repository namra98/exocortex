# Exocortex — One-line installer
# Usage: irm https://raw.githubusercontent.com/namra98/exocortex/main/install.ps1 | iex
# Or run locally: .\install.ps1

param(
    [string]$ClonePath = (Join-Path $HOME "exocortex")
)

$SkillDir = Join-Path (Join-Path (Join-Path $HOME ".copilot") "skills") "exocortex"
$SkillFile = Join-Path $SkillDir "SKILL.md"

# Step 1: Clone repo if not already present
if (Test-Path (Join-Path $ClonePath "NOTES-SKILL.md")) {
    Write-Host "Repo already exists at $ClonePath - pulling latest..." -ForegroundColor Cyan
    Push-Location $ClonePath
    git pull --quiet 2>&1 | Out-Null
    Pop-Location
} else {
    Write-Host "Cloning exocortex to $ClonePath..." -ForegroundColor Cyan
    git clone https://github.com/namra98/exocortex.git $ClonePath 2>&1 | Out-Null
    if (-not (Test-Path (Join-Path $ClonePath "NOTES-SKILL.md"))) {
        Write-Error "Clone failed. Check git access to namra98/exocortex."
        exit 1
    }
}

$RepoRoot = (Resolve-Path $ClonePath).Path

# Step 2: Create skill directory
if (-not (Test-Path $SkillDir)) {
    New-Item -ItemType Directory -Path $SkillDir -Force | Out-Null
}

# Step 3: Generate SKILL.md from template
$TemplatePath = Join-Path $RepoRoot "skill-template.md"
if (-not (Test-Path $TemplatePath)) {
    Write-Error "skill-template.md not found in repo."
    exit 1
}
$SkillContent = (Get-Content $TemplatePath -Raw) -replace '\{\{REPO_ROOT\}\}', $RepoRoot
Set-Content -Path $SkillFile -Value $SkillContent -Encoding UTF8

Write-Host ""
Write-Host "Exocortex installed!" -ForegroundColor Green
Write-Host "  Repo:  $RepoRoot"
Write-Host "  Skill: $SkillFile"
Write-Host ""
Write-Host "Restart Copilot CLI or run /skills reload to activate." -ForegroundColor Yellow
