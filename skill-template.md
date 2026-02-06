---
name: exocortex
description: Personal knowledge management system — capture ideas, log daily activity, manage tasks, and generate recaps via natural language. Works from any directory.
---

# Exocortex — Personal Notes System

The user has a personal knowledge management system stored at `{{REPO_ROOT}}` (GitHub: namra98/exocortex).

When the user wants to capture ideas, log daily activity, manage tasks, or generate recaps, read the full operating manual from `{{REPO_ROOT}}\NOTES-SKILL.md` for detailed templates, file formats, and operational rules.

## System Location

All files live under `{{REPO_ROOT}}\` — always use absolute paths when operating from other directories.

## Quick Reference

### Capturing

| User says | Action | Target |
|-----------|--------|--------|
| "save idea: ..." | Create/append idea file + cross-reference in daily log | `{{REPO_ROOT}}\ideas\<slug>.md` |
| "log: ..." / "today I ..." | Append to today's daily file | `{{REPO_ROOT}}\daily\YYYY\MM\YYYY-MM-DD.md` |
| "add task: ..." | Add to task board under appropriate category | `{{REPO_ROOT}}\tasks\active.md` |
| "done with: ..." | Check off matching task | `{{REPO_ROOT}}\tasks\active.md` |

### Reviewing

| User says | Action | Target |
|-----------|--------|--------|
| "show my tasks" | Read and present open tasks | `{{REPO_ROOT}}\tasks\active.md` |
| "show my ideas" | List and summarize idea files | `{{REPO_ROOT}}\ideas\*.md` |
| "how was my week?" | Synthesize this week's daily logs | `{{REPO_ROOT}}\daily\YYYY\MM\*.md` |
| "search for [topic]" | Grep across all notes | `{{REPO_ROOT}}\**\*.md` |

### Syncing

| User says | Action |
|-----------|--------|
| "sync my notes" / "push notes" | Pull, auto-merge, commit, push |
| "commit my notes" | Stage all, commit with descriptive message (no push) |

### Generating & Maintaining

| User says | Action | Target |
|-----------|--------|--------|
| "weekly recap" | Generate weekly summary from daily logs | `{{REPO_ROOT}}\weekly\YYYY-WNN.md` |
| "monthly recap" | Generate monthly summary | `{{REPO_ROOT}}\monthly\YYYY-MM.md` |
| "archive completed tasks" | Move checked items to archive | `{{REPO_ROOT}}\tasks\archive.md` |

## Key Rules

1. **Always read `{{REPO_ROOT}}\NOTES-SKILL.md`** before first operation in a session — it has the full templates and rules
2. **Append, never overwrite** existing files
3. **Cross-reference ideas in daily log** when capturing: add `- 💡 New idea: [Title](../ideas/<slug>.md)` to today's log
4. **Create parent directories** as needed (e.g., `daily\2026\03\` for a new month)
5. **Slugify idea filenames**: lowercase, hyphens, no special chars
6. **Commit messages**: prefix with `notes:` (e.g., `notes: 2026-02-06 daily log`)
7. **Auto-sync**: Before reading notes, run `git pull --rebase` to get latest. After writing, commit and `git push`. Handle merge conflicts by keeping both versions with conflict markers for the user to resolve.
