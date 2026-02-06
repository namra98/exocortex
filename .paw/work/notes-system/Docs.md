# Personal Notes System

## Overview

The Personal Notes System is a markdown-based knowledge management system stored in a git repository, designed to be operated entirely through natural language interaction with AI CLI assistants (GitHub Copilot CLI, Claude CLI). It replaces mental tracking and tool-fragmented note-taking with a structured set of plain-text files that any AI session can immediately understand and operate.

The system covers three life domains — work, personal, and learning/study — with five content types: daily logs, ideas, active tasks, archived tasks, and periodic recaps (weekly/monthly). A single instruction file (`NOTES-SKILL.md`) at the repo root serves as the AI's operating manual, enabling zero-onboarding session continuity.

## Architecture and Design

### High-Level Architecture

```
User ←→ AI CLI Assistant ←→ Markdown Files ←→ Git
         (reads NOTES-SKILL.md)   (the data)    (history + backup)
```

There is no application layer. The AI CLI assistant IS the application — it reads `NOTES-SKILL.md` to learn the system's structure and rules, then operates directly on markdown files. Git provides version history and remote backup.

### Design Decisions

| Decision | Rationale |
|----------|-----------|
| **Single skill file** (not per-domain) | Simpler maintenance, AI can route based on content. One file means one place to update conventions. |
| **Action-based command vocabulary** (capture/review/generate/maintain) | Matches how users think — "I want to save something" not "I want to create an idea entity." |
| **Templates embedded in skill file** (not separate .template files) | Self-contained per NFR. AI only needs to read one file to know all formats. |
| **ISO 8601 week numbering** | Unambiguous across locales and platforms. Monday-start weeks match work patterns. |
| **Daily files organized by year/month** (`daily/YYYY/MM/`) | Prevents any single directory from growing large. Natural filesystem-level time browsing. |
| **One file per idea** (not a single ideas list) | Ideas grow with notes, experiments, and status changes. Separate files allow independent evolution. |
| **Single task board file** (not one per category) | Tasks are typically scanned all at once ("what's on my plate?"). Single file enables fast overview. |
| **Manual commit default** | Reduces noise. User controls when to snapshot. Auto-commit documented as future option. |
| **Sections omitted when empty** (daily logs) | Keeps files clean. If nothing personal happened today, no empty "## Personal" section. |

### Integration Points

- **Git remote**: User configures manually. System works fully offline; push is optional.
- **Copilot CLI**: Reads `NOTES-SKILL.md` via the `AGENTS.md` / custom instructions file discovery mechanism.
- **Claude CLI**: Can be pointed to `NOTES-SKILL.md` via its context/instructions system.
- **VS Code / editors**: All files are plain markdown — browseable and editable in any tool.
- **GitHub web UI**: If pushed to GitHub, all files render natively with search.

## User Guide

### Prerequisites

- Git installed locally
- An AI CLI assistant (Copilot CLI or Claude CLI)
- A terminal open in the `C:\notes` directory

### Basic Usage

**Capture an idea:**
> "save idea: use AI agents to automate weekly status reports"

Creates `ideas/ai-agents-weekly-status-reports.md` with status "exploring" and today's date.

**Log daily work:**
> "log: finished the API migration, reviewed 3 PRs, had design discussion about auth"

Appends to `daily/2026/02/2026-02-06.md` (creates if first entry today).

**Check tasks:**
> "show my tasks"

AI reads `tasks/active.md` and presents categorized open items.

**Add a task:**
> "add task: review the transformer attention paper"

Adds to Learning/Study section of `tasks/active.md`.

**Complete a task:**
> "done with: review transformer paper"

Checks off the matching item in `tasks/active.md`.

**Generate a recap:**
> "weekly recap"

AI reads all daily files for the current week, synthesizes into `weekly/2026-W06.md`.

**Commit changes:**
> "commit my notes"

AI stages all changes, commits with a descriptive message like `notes: 2026-02-06 daily log`.

### Advanced Usage

**Retroactive logging:**
> "log for yesterday: had a productive brainstorming session about the new feature"

Creates or appends to yesterday's daily file.

**Search across everything:**
> "search for kubernetes"

AI greps across all markdown files, presents results grouped by file.

**Archive completed tasks:**
> "archive completed tasks"

Moves all checked-off items from `active.md` to `archive.md`, preserving category structure.

**Add custom categories:**
Edit `tasks/active.md` and `tasks/archive.md` directly — add a new `## Section` header. The AI will recognize and use it automatically.

## Configuration Options

| Setting | Default | How to Change |
|---------|---------|---------------|
| Commit strategy | Manual | Future: add git hook or scheduled task for auto-commit |
| Task categories | Work, Personal, Learning/Study, Someday/Maybe | Edit section headers in `tasks/active.md` and `tasks/archive.md` |
| Daily log sections | Summary, Work, Personal, Learning/Study, Ideas, Tasks, Tomorrow | Modify the template in `NOTES-SKILL.md` or just start using different sections in daily files |
| Week numbering | ISO 8601 (Monday start) | Change in `NOTES-SKILL.md` weekly recap template |

## Testing

### How to Test

1. Open a fresh Copilot CLI session in `C:\notes`
2. Say "show my tasks" — should list items from `tasks/active.md` without any setup
3. Say "save idea: test idea for verification" — should create `ideas/test-idea-for-verification.md`
4. Say "log: tested the notes system" — should create/append to today's daily file
5. Say "search for verification" — should find the idea file and daily log
6. Say "weekly recap" — should generate a weekly file from available daily logs

### Edge Cases

| Scenario | Expected Behavior |
|----------|------------------|
| Log to a past date | AI creates the file at the correct `daily/YYYY/MM/` path |
| Recap with no data | AI reports no entries found for the period |
| Near-duplicate idea names | AI warns before creating, offers to append to existing |
| Ambiguous task completion | AI asks user to clarify which task they mean |
| Very long daily file | Naturally bounded by one day; not a realistic concern |

## Limitations and Future Work

### Known Limitations
- **No automated scheduling**: Recaps are on-demand only; no cron or GitHub Actions
- **No HTML UI**: Browsing is via terminal, editor, or GitHub web UI
- **Single device assumed**: No conflict resolution for multi-device editing
- **Skill file discovery**: Some AI tools may not auto-load `NOTES-SKILL.md`; user may need to reference it manually

### Future Options (Out of Scope for v1)
- **Auto-commit**: Git hook or scheduled task to commit daily
- **HTML dashboard**: Static site generator to render notes as a browseable website
- **GitHub Actions**: Automated weekly recap generation on schedule
- **Mobile access**: GitHub mobile app provides read access if pushed to remote
- **External integrations**: Calendar sync, Jira import, email digest
