# Personal Notes System Implementation Plan

## Overview
Implement a markdown + git personal knowledge management system operated through AI CLI assistants. The system consists of a folder structure, markdown templates for each content type, and a comprehensive NOTES-SKILL.md that serves as the AI's instruction manual.

## Current State Analysis
- Empty git repo on `feature/notes-system` branch with `.paw/` workflow artifacts only
- No existing files, folders, or conventions to work around
- Git initialized with `main` branch as base

## Desired End State
- Complete folder hierarchy: `daily/`, `weekly/`, `monthly/`, `ideas/`, `tasks/`
- Populated template files: `tasks/active.md`, `tasks/archive.md`
- NOTES-SKILL.md at repo root with full command vocabulary, file format specs, and operational rules
- `.gitignore` for OS/editor artifacts
- A seed daily log demonstrating the template in action
- All files committed and ready for use

**Verification**: Open a fresh Copilot CLI session in `C:\notes`, say "show my tasks" — the AI reads NOTES-SKILL.md and responds correctly using the task board.

## What We're NOT Doing
- No HTML UI, dashboards, or static site generators
- No GitHub Actions, CI/CD, or automation scripts
- No GitHub remote setup (user handles this)
- No auto-commit implementation (documented as future option only)
- No custom CLI tools or scripts — the AI CLI IS the interface

## Phase Status
- [ ] **Phase 1: Folder Structure & Templates** - Create directory hierarchy and all content template files
- [ ] **Phase 2: NOTES-SKILL.md** - Write the comprehensive AI instruction file covering all commands, formats, and rules
- [ ] **Phase 3: Documentation** - Create Docs.md technical reference

## Phase Candidates
<!-- Potential additions identified during planning -->
- [ ] Sample data: pre-populate a week of example daily logs for recap testing
- [ ] Configuration file: a `config.md` or YAML for user preferences (auto-commit toggle, default categories)

---

## Phase 1: Folder Structure & Templates

### Objective
Create the complete directory hierarchy and all seed/template files that the system needs before NOTES-SKILL.md can reference them.

### Changes Required:

- **`daily/2026/02/`**: Create year/month directory structure. No template file needed — daily files are created on-demand by the AI per NOTES-SKILL.md instructions.

- **`weekly/`**: Create directory. Weekly recap files are generated on-demand (e.g., `2026-W06.md`).

- **`monthly/`**: Create directory. Monthly recap files are generated on-demand (e.g., `2026-02.md`).

- **`ideas/`**: Create directory. Idea files are created on-demand with slugified names (e.g., `copilot-cli-experiments.md`).

- **`tasks/active.md`**: Create with three domain categories (Work, Personal, Learning/Study) plus a Someday/Maybe section. Pre-populate with the initial tasks from this setup process. (FR-003, FR-012)

- **`tasks/archive.md`**: Create with header and structure matching active.md categories. Initially empty. (FR-004)

- **`.gitignore`**: OS artifacts (Thumbs.db, .DS_Store), editor temp files (*.swp, *~). Keep minimal.

- **`daily/2026/02/2026-02-06.md`**: Seed daily log documenting the system setup. Demonstrates the daily log template in action — serves as both content and a reference example. (FR-001, FR-011)

### Success Criteria:

#### Automated Verification:
- [ ] All directories exist: `daily/2026/02/`, `weekly/`, `monthly/`, `ideas/`, `tasks/`
- [ ] All files exist: `tasks/active.md`, `tasks/archive.md`, `.gitignore`, `daily/2026/02/2026-02-06.md`
- [ ] Git status clean after commit

#### Manual Verification:
- [ ] `tasks/active.md` has Work, Personal, Learning/Study, and Someday/Maybe sections with checkbox items
- [ ] `tasks/archive.md` has matching category structure, empty of items
- [ ] Seed daily log follows the template format (Summary, Work, Ideas, Tasks Completed, Tomorrow)
- [ ] `.gitignore` covers common OS and editor artifacts

---

## Phase 2: NOTES-SKILL.md

### Objective
Write the self-contained AI instruction file that enables any Copilot CLI or Claude CLI session to operate the entire notes system without prior context. This is the most critical deliverable — it IS the interface.

### Changes Required:

- **`NOTES-SKILL.md`**: Single file at repo root containing:
  - **System overview**: What this repo is, single-user, three domains
  - **Directory structure reference**: Complete tree with descriptions
  - **Command vocabulary table**: Natural language triggers mapped to actions (capture → create/append, review → read/summarize, search → grep across files, maintain → archive/commit)
  - **File format specifications**: Templates for daily log, idea, task board, weekly recap, monthly recap — each with field descriptions and examples
  - **Operational rules**: 8-10 rules covering file creation, naming conventions, append-vs-overwrite, timestamps, cross-referencing, commit messages, duplicate detection
  - **Configuration section**: Document manual commit as default, describe how auto-commit could be added (future option per FR-009)
  - (FR-007, FR-008, FR-009, FR-010, FR-011, FR-012)

### Design Decisions:
- Skill file uses Copilot CLI's `AGENTS.md` / custom instructions pattern — placed at repo root so it's auto-loaded
- Command vocabulary organized by action type (Capture, Review, Maintain) rather than by entity — matches how users think
- Templates embedded in the skill file rather than as separate `.template` files — keeps it self-contained per NFR
- ISO 8601 week numbering for weekly recaps (e.g., `2026-W06`) for unambiguous cross-platform compatibility

### Success Criteria:

#### Automated Verification:
- [ ] `NOTES-SKILL.md` exists at repo root
- [ ] File contains all required sections (structure, commands, formats, rules)
- [ ] Git status clean after commit

#### Manual Verification:
- [ ] A fresh Copilot CLI session in `C:\notes` can read the skill file and respond to "show my tasks" correctly
- [ ] Command vocabulary covers all 7 user stories from Spec.md
- [ ] Search commands ("search for X", "find notes about X") documented in command vocabulary (SC-009)
- [ ] Templates match the structure used in the seed daily log (Phase 1)
- [ ] Rules are unambiguous — no room for AI to guess at file paths or formats
- [ ] Configuration section documents manual commit and auto-commit future path

---

## Phase 3: Documentation

### Objective
Create Docs.md technical reference capturing the implementation decisions, file format rationale, and usage guide for future reference.

### Changes Required:

- **`.paw/work/notes-system/Docs.md`**: Technical reference covering:
  - Architecture overview (folder structure rationale, why markdown, why git)
  - File format decisions and trade-offs
  - NOTES-SKILL.md design choices (why single file, why action-based commands)
  - Usage quick-start for the user
  - Known limitations and future options (auto-commit, HTML dashboard, etc.)

### Success Criteria:

#### Automated Verification:
- [ ] `Docs.md` exists in `.paw/work/notes-system/`
- [ ] Git status clean after commit

#### Manual Verification:
- [ ] Docs accurately reflect what was implemented
- [ ] Design decisions are captured with rationale
- [ ] Future options section matches Spec.md out-of-scope items

---

## References
- Issue: none
- Spec: `.paw/work/notes-system/Spec.md`
- Research: none (greenfield project)
