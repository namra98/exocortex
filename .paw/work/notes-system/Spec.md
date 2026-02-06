# Feature Specification: Personal Notes System

**Branch**: feature/notes-system  |  **Created**: 2026-02-06  |  **Status**: Draft
**Input Brief**: Markdown + git personal knowledge system optimized for AI CLI assistants

## Overview

The Personal Notes System is a plain-text knowledge management system that lets a single user capture thoughts, track tasks, log daily work, and manage ideas — all through natural language interaction with AI CLI assistants like GitHub Copilot CLI and Claude CLI.

Today, the user relies on mental tracking and OneNote, which leads to lost ideas, forgotten tasks, and no history of what was accomplished. The new system replaces this with a structured set of markdown files in a git repository. The user speaks naturally ("save this idea", "what did I do this week?", "show my tasks") and the AI assistant knows exactly where to store, retrieve, and summarize information.

The system spans work, personal life, and learning/study (research papers, interests, skill-building). A single instruction file (NOTES-SKILL.md) at the repo root gives any AI assistant session instant awareness of the system's structure, file formats, and command vocabulary — so any new session can pick up exactly where the last one left off with zero onboarding.

Git provides version history, backup (via GitHub remote), and the ability to see how thinking evolved over time. The approach is deliberately low-tech: no databases, no apps, no APIs — just files that any tool can read.

## Objectives

- Enable frictionless idea and task capture through natural language AI commands
- Provide instant retrieval of active work, open tasks, and recent history on demand
- Maintain a daily log habit with minimal effort (AI helps structure entries)
- Generate periodic summaries (weekly/monthly) by synthesizing daily logs
- Organize knowledge across three life domains (work, personal, learning/study) in a unified system
- Ensure any AI CLI session can operate the system immediately via a self-contained skill file
- Preserve full history of notes and changes through git version control

## User Scenarios & Testing

### User Story P1 – Capture an Idea on the Fly
Narrative: User is working and has a sudden idea about a side project. They tell the AI "save idea: build a CLI dashboard for notes" and continue working, confident it's stored.
Independent Test: Tell the AI to save an idea, then in a new session ask "show my ideas" — the idea appears.
Acceptance Scenarios:
1. Given the user says "save idea: <description>", When the AI processes the command, Then a new markdown file is created in the ideas folder with proper template structure, status "exploring", and today's date
2. Given an idea file already exists for the topic, When the user provides additional notes, Then the AI appends to the existing file rather than creating a duplicate
3. Given the user provides a multi-domain idea (e.g., both work and learning), When the AI stores it, Then it is stored in a single file with appropriate tags/context

### User Story P2 – Log Daily Activity
Narrative: At the end of the day (or throughout), the user tells the AI what they worked on, and a structured daily log entry is created or updated.
Independent Test: Say "log: finished the API migration and reviewed 3 PRs" — verify today's daily file is created/updated with the entry.
Acceptance Scenarios:
1. Given no daily file exists for today, When the user logs an entry, Then a new daily file is created with the standard template and the entry is placed in the appropriate section
2. Given a daily file already exists, When the user logs another entry, Then the new entry is appended to the correct section without overwriting existing content
3. Given multiple entries throughout the day, When the user reviews the daily file, Then entries appear in chronological order with optional timestamps

### User Story P3 – Check Active Tasks and Status
Narrative: User starts a new CLI session and asks "what are my active items?" — the AI reads the task board and presents a clear summary.
Independent Test: Ask "show my tasks" and verify the AI returns a categorized list of open items.
Acceptance Scenarios:
1. Given active tasks exist across multiple categories, When the user asks for active items, Then all unchecked tasks are presented grouped by category
2. Given the user asks "what are my active items?", When tasks and recent logs exist, Then the AI presents a task-focused status summary
3. Given no active tasks exist, When the user asks for status, Then the AI reports no open tasks

### User Story P4 – Add and Complete Tasks
Narrative: User says "add task: review the new ML paper on transformers" and later "done with: review ML paper". The task moves from active to completed.
Independent Test: Add a task, complete it, verify it's checked off in active tasks and archived when appropriate.
Acceptance Scenarios:
1. Given the user says "add task: <description>", When the AI processes it, Then the task appears as an unchecked item in the appropriate category of the active tasks file
2. Given the user completes a task, When they say "done with: <task>", Then the task is checked off in the active file
3. Given multiple completed tasks accumulate, When the user says "archive completed tasks", Then checked-off items move to the archive file

### User Story P5 – Generate Weekly Recap
Narrative: At the end of the week, the user says "weekly recap" and the AI reads all daily logs from that week to produce a structured summary.
Independent Test: After several days of logging, say "weekly recap" — verify a weekly recap file is generated with highlights, task counts, and reflection prompts.
Acceptance Scenarios:
1. Given daily logs exist for the current week, When the user requests a weekly recap, Then a weekly file is created summarizing highlights, tasks completed/added, and ideas captured
2. Given a weekly recap already exists for the current week, When the user requests it again, Then the existing recap is updated rather than duplicated
3. Given partial daily coverage (e.g., 3 of 5 workdays logged), When the recap is generated, Then it covers only logged days and notes the coverage

### User Story P6 – Generate Monthly Recap
Narrative: At month end, user requests a monthly overview synthesized from weekly recaps and daily logs.
Independent Test: Say "monthly recap" after a month of use — verify a monthly file is generated.
Acceptance Scenarios:
1. Given weekly recaps and daily logs exist for the month, When the user requests a monthly recap, Then a monthly file is created with high-level accomplishments, idea status, and focus areas
2. Given the month is still in progress, When the user requests a monthly recap, Then a partial recap is generated covering the month so far

### User Story P7 – Seamless Session Continuity
Narrative: User opens a brand new Copilot CLI session in the notes directory. Without any setup, the AI immediately understands the notes system and can operate it.
Independent Test: Open a fresh CLI session, say "show my tasks" — it works without any preamble.
Acceptance Scenarios:
1. Given NOTES-SKILL.md exists at the repo root, When a new AI CLI session starts in the repo directory, Then the AI can immediately process notes commands
2. Given the skill file describes all file locations and formats, When the AI needs to find or create a file, Then it uses the correct path and template without asking

### Edge Cases
- User tries to log to a date in the past ("log for yesterday: ...") — AI creates/appends to that date's file
- User asks for a recap of a week/month with no entries — AI reports no data found
- Two ideas have very similar names — AI uses slugified filenames and warns if near-duplicate exists
- Daily file grows very large (many entries) — naturally bounded by being one day
- User asks to search across all notes ("search for kubernetes") — AI greps across all files
- Task description is ambiguous for completion ("done with: review") — AI asks for clarification if multiple tasks match

## Requirements

### Functional Requirements
- FR-001: Store daily logs as individual markdown files organized by year and month (Stories: P2)
- FR-002: Store ideas as individual markdown files with status tracking (Stories: P1)
- FR-003: Maintain an active task board in a single markdown file with categorized sections (Stories: P3, P4)
- FR-004: Support task archival from active to archive file (Stories: P4)
- FR-005: Generate weekly recap files by synthesizing that week's daily logs (Stories: P5)
- FR-006: Generate monthly recap files by synthesizing daily logs and weekly recaps (Stories: P6)
- FR-007: Provide a self-contained skill file (NOTES-SKILL.md) that enables any AI CLI session to operate the system (Stories: P7)
- FR-008: Support natural language command vocabulary for all CRUD operations (Stories: P1-P7)
- FR-009: Support git commit of all changes on user command, with configurable auto-commit option (Stories: P7)
- FR-010: Support searching across all note files by keyword or topic (Stories: P3)
- FR-011: Support retroactive daily logging (entries for past dates) (Edge case)
- FR-012: Organize content across three domains: work, personal, and learning/study (Stories: P1, P4)

### Key Entities
- **Daily Log**: A single day's record of work, ideas, completed tasks, and follow-ups
- **Idea**: A persistent document tracking a specific idea or experiment from inception through resolution
- **Task**: An actionable item with status (open/done), category, and optional context
- **Recap**: A synthesized summary of activity over a time period (weekly or monthly)
- **Skill File**: The instruction document that gives AI assistants operational knowledge of the system

### Cross-Cutting / Non-Functional
- All content stored as plain markdown — no proprietary formats, no binary files
- File and folder naming uses ISO dates and URL-safe slugs for cross-platform compatibility
- System must work offline (git push is optional, not required for operation)
- Skill file must be self-contained — no external dependencies or references to function

## Success Criteria
- SC-001: A user can capture an idea in a single natural language command and retrieve it in a new session (FR-002, FR-007, FR-008)
- SC-002: Daily log files are created with consistent structure and support multiple entries per day (FR-001)
- SC-003: Active tasks can be listed, added, completed, and archived through natural language (FR-003, FR-004, FR-008)
- SC-004: Weekly recap accurately reflects the content of that week's daily logs (FR-005)
- SC-005: Monthly recap synthesizes the month's activity into actionable summary (FR-006)
- SC-006: A fresh AI CLI session can operate the system without prior context, using only NOTES-SKILL.md (FR-007)
- SC-007: All files use consistent markdown formatting and predictable file paths (FR-001, FR-002, FR-003)
- SC-008: Git commits can be triggered manually and the system documents a path to auto-commit configuration (FR-009)
- SC-009: User can search across all notes and get relevant results (FR-010)
- SC-010: Tasks and ideas are organized into distinct domain categories (work, personal, learning/study) that the user can browse independently (FR-012)

## Assumptions
- The user's AI CLI assistants (Copilot CLI, Claude CLI) can read files from the working directory and use them as context — NOTES-SKILL.md relies on this capability
- Single user, single device is the primary use case — no conflict resolution needed
- The git remote (GitHub) is set up separately by the user — this system does not automate remote creation
- Recaps are generated on-demand by the AI, not via scheduled automation
- Task categories (work, personal, learning/study) are sufficient — user can add more by editing templates
- Manual commit is the default; auto-commit is documented as a configurable option but not implemented in v1

## Scope

In Scope:
- Folder structure design and creation
- File templates for all content types (daily, idea, task, recap)
- NOTES-SKILL.md with complete AI instruction set
- Git repository initialization and .gitignore
- Natural language command vocabulary documented in skill file
- Task categorization across work, personal, and learning/study domains

Out of Scope:
- HTML/web UI or dashboard (deferred to future phase)
- GitHub Actions or CI/CD automation
- Mobile app or push notifications
- Multi-user support or access control
- Automated scheduling (cron-based recaps, auto-commit timers)
- Integration with external tools (calendars, Jira, email)
- GitHub remote repository creation

## Dependencies
- Git installed on local machine
- AI CLI assistant that reads workspace files (Copilot CLI, Claude CLI)
- GitHub account (for remote backup — optional for core functionality)

## Risks & Mitigations
- **Skill file not loaded by AI**: Some AI CLI tools may not automatically read NOTES-SKILL.md. Mitigation: Document how to reference the file manually; keep the filename conventional
- **Template drift**: Over time, actual files may diverge from templates defined in skill file. Mitigation: Templates are guidelines, not strict schemas — the AI adapts to what it finds
- **Information overload**: After months of use, searching becomes harder. Mitigation: Folder-by-date structure keeps any single directory small; recaps provide summarized access to history
- **Commit discipline**: User may forget to commit. Mitigation: Skill file includes commit reminders; auto-commit documented as future option

## References
- WorkflowContext: .paw/work/notes-system/WorkflowContext.md
