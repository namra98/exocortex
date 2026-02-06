# 🧠 Exocortex

Personal knowledge management system designed for AI CLI assistants (Copilot CLI, Claude CLI).

Capture ideas, log daily activity, manage tasks, and generate weekly/monthly recaps — all in markdown, operated via natural language.

## Quick Start

**One-line install** (clones repo + installs Copilot CLI skill):

```powershell
irm https://raw.githubusercontent.com/namra98/exocortex/main/install.ps1 | iex
```

That's it. Restart Copilot CLI or run `/skills reload`.

Then in any Copilot CLI session:

```
> save idea: build a chrome extension for tab management
> log: finished the API refactor, merged PR #42
> add task: review design doc for auth service
> show my tasks
> weekly recap
```

## What Gets Installed

The install script creates `~/.copilot/skills/exocortex/SKILL.md` — a lightweight skill file that points to this repo's `NOTES-SKILL.md` (the full operating manual). The skill auto-detects your repo path, so it works regardless of where you clone it.

## Structure

```
exocortex/
├── daily/YYYY/MM/YYYY-MM-DD.md   # Daily logs
├── ideas/<slug>.md                 # Idea files
├── tasks/active.md                 # Task board
├── tasks/archive.md                # Completed tasks
├── weekly/YYYY-WNN.md              # Weekly recaps
├── monthly/YYYY-MM.md              # Monthly recaps
├── config.md                       # User preferences
├── NOTES-SKILL.md                  # Full AI operating manual
└── install.ps1                     # Skill installer
```

## Multi-Machine Setup

Run the same one-liner on each machine. The installer clones to `~/exocortex` (or pulls latest if already cloned) and generates a machine-local skill file. All machines auto-sync via git — the AI agent pulls before reading and pushes after writing.

## License

Private — personal use.
