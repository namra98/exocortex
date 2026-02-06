# Notes System Skill

You are managing a personal knowledge and task tracking system. This file tells you everything you need to operate it.

## System Overview

- **Owner**: Single user (personal system)
- **Domains**: Work, Personal, Learning/Study
- **Interface**: Natural language via AI CLI assistants (Copilot CLI, Claude CLI)
- **Storage**: Plain markdown files in a git repository
- **Location**: This repo root

## Directory Structure

```
<repo-root>/
├── daily/YYYY/MM/YYYY-MM-DD.md   # Daily activity logs (one file per day)
├── weekly/YYYY-WNN.md             # Weekly recaps (generated on demand)
├── monthly/YYYY-MM.md             # Monthly recaps (generated on demand)
├── ideas/<slug>.md                # Ideas and experiments (one file per idea)
├── tasks/
│   ├── active.md                  # Running task board (categorized)
│   └── archive.md                 # Completed/abandoned tasks
└── NOTES-SKILL.md                 # This file
```

## Command Vocabulary

Respond to these natural language patterns. The user won't use exact phrases — interpret intent.

### Capturing

| User says (examples) | Action |
|----------------------|--------|
| "save idea: ..." / "idea: ..." / "I had a thought about ..." | Create or append to a file in `ideas/` |
| "log: ..." / "today I ..." / "note: ..." | Append to today's daily file |
| "log for yesterday: ..." / "log for Monday: ..." | Append to that date's daily file (create if needed) |
| "add task: ..." / "todo: ..." / "I need to ..." | Add to `tasks/active.md` under appropriate category |
| "done with: ..." / "completed: ..." / "finished ..." | Check off matching task in `tasks/active.md` |

### Reviewing

| User says (examples) | Action |
|----------------------|--------|
| "show my tasks" / "what are my active items?" | Read and present `tasks/active.md` |
| "show my ideas" / "what ideas do I have?" | List files in `ideas/`, summarize each |
| "what did I do today?" / "today's log" | Read and present today's daily file |
| "how was my week?" / "this week's summary" | Read this week's daily files, synthesize a summary |
| "what did I do in January?" | Read that month's daily files or monthly recap |
| "search for [topic]" / "find notes about [topic]" | Grep across all files for the topic |

### Generating

| User says (examples) | Action |
|----------------------|--------|
| "weekly recap" | Generate `weekly/YYYY-WNN.md` from this week's daily files. If a recap already exists for the period, update it rather than creating a duplicate. |
| "monthly recap" | Generate `monthly/YYYY-MM.md` from the month's daily files and weekly recaps. If a recap already exists, update it. |

### Maintaining

| User says (examples) | Action |
|----------------------|--------|
| "archive completed tasks" | Move checked-off items from `active.md` to `archive.md` |
| "commit my notes" / "save to git" | Stage all changes, commit with descriptive message |
| "push my notes" | Push to remote (assumes remote is configured) |

## File Formats

### Daily Log (`daily/YYYY/MM/YYYY-MM-DD.md`)

```markdown
# YYYY-MM-DD (Day of Week)

## Summary
Brief 1-2 sentence summary of the day.

## Work
- What was worked on, decisions made, progress

## Personal
- Personal activities, errands, life events (if any)

## Learning / Study
- Papers read, courses, new skills, research (if any)

## Ideas & Observations
- Captured thoughts, things to explore later

## Tasks Completed
- [x] Task description

## Tomorrow / Follow-up
- Things to pick up next
```

**Notes on daily logs:**
- Omit empty sections — if nothing personal happened, skip the Personal section
- When adding entries mid-day, prefix with time: `- [14:30] Had a call about X`
- Multiple entries throughout the day are fine — append, never overwrite

### Idea File (`ideas/<slug>.md`)

```markdown
# Idea Title

**Status:** exploring | active | parked | done | abandoned
**Created:** YYYY-MM-DD
**Updated:** YYYY-MM-DD
**Domain:** work | personal | learning | cross-domain

## What
Brief description of the idea.

## Why
Motivation, problem it solves, what sparked it.

## Notes
- Running notes, experiments, findings
- Add entries with dates as the idea evolves

## Next Steps
- [ ] Action items related to this idea
```

**Status values:**
- `exploring` — just captured, thinking about it
- `active` — actively working on or experimenting with
- `parked` — interesting but not a priority right now
- `done` — completed or fully explored
- `abandoned` — decided not to pursue (document why)

### Active Tasks (`tasks/active.md`)

```markdown
# Active Tasks

## Work
- [ ] Task description — *context/notes*

## Personal
- [ ] Task description

## Learning / Study
- [ ] Task description

## Someday / Maybe
- [ ] Low priority or aspirational items
```

**Rules for tasks:**
- Place tasks in the category that best fits
- Add brief context after an em dash if helpful: `- [ ] Review ML paper — *recommended by Alex*`
- When completing: change `[ ]` to `[x]`
- Periodically archive completed tasks to keep the board clean

### Weekly Recap (`weekly/YYYY-WNN.md`)

```markdown
# Week NN, YYYY (Mon DD – Sun DD)

## Highlights
- Key accomplishments and notable events

## Work
- Work-related progress summary

## Learning
- What was studied or learned

## Ideas Captured
- New ideas logged this week (link to idea files if relevant)

## Tasks
- Completed: N
- Added: N
- Carried over: N

## Reflection
What went well, what could improve, focus for next week.
```

**Week numbering:** Use ISO 8601 weeks (Monday start). Example: `2026-W06.md`.

### Monthly Recap (`monthly/YYYY-MM.md`)

```markdown
# YYYY-MM (Month Name)

## Summary
High-level month overview in 2-3 sentences.

## Key Accomplishments
- Major completions and milestones

## Ideas & Experiments
- Status of ongoing ideas/experiments

## Learning
- Key things studied or learned

## Metrics
- Tasks completed: N
- Ideas captured: N
- Days logged: N / total days

## Focus for Next Month
- Top priorities and goals
```

## Operational Rules

1. **Check before creating**: Always check if today's daily file or an idea file already exists before creating a new one. Append to existing files — never overwrite.

2. **Create parent directories**: When creating a daily file for a new month or year, create the `YYYY/MM/` directories first.

3. **Slugify idea filenames**: Convert idea titles to lowercase, replace spaces with hyphens, remove special characters. Example: "Build a CLI Dashboard" → `build-a-cli-dashboard.md`.

4. **Warn on near-duplicates**: Before creating a new idea file, check if a file with a similar slug exists. If so, ask the user whether to append to the existing file or create a new one.

5. **Timestamp mid-day entries**: If the daily file already has entries and the user adds more, prefix new entries with the current time in `[HH:MM]` format.

6. **Cross-reference**: When an idea relates to a task or daily log, mention the file path. Example: `See ideas/cli-dashboard.md`.

7. **Task completion matching**: When the user says "done with X", find the best matching unchecked task. If multiple tasks match, ask the user to clarify. Use fuzzy matching — the user won't remember exact wording.

8. **Commit message format**: Use descriptive messages prefixed with `notes:`. Examples:
   - `notes: 2026-02-06 daily log`
   - `notes: add idea - cli-dashboard`
   - `notes: weekly recap W06`
   - `notes: archive completed tasks`

9. **Search behavior**: When the user asks to search, use grep/ripgrep across all markdown files in the repo. Present results grouped by file with relevant context lines.

10. **Recap generation**: When generating recaps, read ALL relevant source files (daily logs for the period). Synthesize — don't just concatenate. Highlight patterns, themes, and progress. If some days have no logs, note the coverage.

## Configuration

### Commit Strategy
- **Default**: Manual — user says "commit my notes" when ready
- **Future option**: Auto-commit can be enabled by adding a git hook or scheduled task. This is not implemented in v1 but the system is designed to support it.

### Adding Categories
To add a new task category (e.g., "Side Projects"), edit `tasks/active.md` and `tasks/archive.md` to add a new `## Section` header. The AI will automatically recognize and use new categories.

### Adding Domains
The daily log template sections can be customized. Add or remove sections as needed — the AI adapts to whatever sections it finds in existing files.
