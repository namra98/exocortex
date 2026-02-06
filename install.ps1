# Exocortex — Install Copilot CLI skill
# Run from within the cloned exocortex repo directory

$RepoRoot = (Get-Location).Path
$SkillDir = Join-Path $HOME ".copilot" "skills" "exocortex"
$SkillFile = Join-Path $SkillDir "SKILL.md"

# Verify we're in the right repo
if (-not (Test-Path (Join-Path $RepoRoot "NOTES-SKILL.md"))) {
    Write-Error "NOTES-SKILL.md not found. Run this from the exocortex repo root."
    exit 1
}

# Create skill directory
if (-not (Test-Path $SkillDir)) {
    New-Item -ItemType Directory -Path $SkillDir -Force | Out-Null
}

# Generate SKILL.md with this machine's repo path
$SkillContent = @"
---
name: exocortex
description: Personal knowledge management system — capture ideas, log daily activity, manage tasks, and generate recaps via natural language. Works from any directory.
---

# Exocortex — Personal Notes System

The user has a personal knowledge management system stored at ``$RepoRoot`` (GitHub: namra98/exocortex).

When the user wants to capture ideas, log daily activity, manage tasks, or generate recaps, read the full operating manual from ``$RepoRoot\NOTES-SKILL.md`` for detailed templates, file formats, and operational rules.

## System Location

All files live under ``$RepoRoot\`` — always use absolute paths when operating from other directories.

## Quick Reference

### Capturing

| User says | Action | Target |
|-----------|--------|--------|
| "save idea: ..." | Create/append idea file + cross-reference in daily log | ``$RepoRoot\ideas\<slug>.md`` |
| "log: ..." / "today I ..." | Append to today's daily file | ``$RepoRoot\daily\YYYY\MM\YYYY-MM-DD.md`` |
| "add task: ..." | Add to task board under appropriate category | ``$RepoRoot\tasks\active.md`` |
| "done with: ..." | Check off matching task | ``$RepoRoot\tasks\active.md`` |

### Reviewing

| User says | Action | Target |
|-----------|--------|--------|
| "show my tasks" | Read and present open tasks | ``$RepoRoot\tasks\active.md`` |
| "show my ideas" | List and summarize idea files | ``$RepoRoot\ideas\*.md`` |
| "how was my week?" | Synthesize this week's daily logs | ``$RepoRoot\daily\YYYY\MM\*.md`` |
| "search for [topic]" | Grep across all notes | ``$RepoRoot\**\*.md`` |

### Generating & Maintaining

| User says | Action | Target |
|-----------|--------|--------|
| "weekly recap" | Generate weekly summary from daily logs | ``$RepoRoot\weekly\YYYY-WNN.md`` |
| "monthly recap" | Generate monthly summary | ``$RepoRoot\monthly\YYYY-MM.md`` |
| "archive completed tasks" | Move checked items to archive | ``$RepoRoot\tasks\archive.md`` |
| "commit my notes" | Stage all, commit with descriptive message | ``$RepoRoot`` repo |

## Key Rules

1. **Always read ``$RepoRoot\NOTES-SKILL.md``** before first operation in a session — it has the full templates and rules
2. **Append, never overwrite** existing files
3. **Cross-reference ideas in daily log** when capturing: add ``- 💡 New idea: [Title](../ideas/<slug>.md)`` to today's log
4. **Create parent directories** as needed (e.g., ``daily\2026\03\`` for a new month)
5. **Slugify idea filenames**: lowercase, hyphens, no special chars
6. **Commit messages**: prefix with ``notes:`` (e.g., ``notes: 2026-02-06 daily log``)
"@

Set-Content -Path $SkillFile -Value $SkillContent -Encoding UTF8

Write-Host ""
Write-Host "Exocortex skill installed!" -ForegroundColor Green
Write-Host "  Skill file: $SkillFile"
Write-Host "  Notes root: $RepoRoot"
Write-Host ""
Write-Host "Restart Copilot CLI or run /skills reload to activate." -ForegroundColor Yellow
