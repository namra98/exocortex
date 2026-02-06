# 🧠 Exocortex

Personal knowledge management system designed for AI CLI assistants (Copilot CLI, Claude CLI).

Capture ideas, log daily activity, manage tasks, and generate weekly/monthly recaps — all in markdown, operated via natural language.

## Quick Start

```bash
# Clone the repo
git clone git@github.com:namra98/exocortex.git
cd exocortex

# Install Copilot CLI skill (auto-detects repo path)
.\install.ps1

# Restart Copilot CLI or run /skills reload
```

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

Clone the repo on each machine and run `.\install.ps1`. The skill file is generated with machine-local paths — the repo itself stays portable.

## License

Private — personal use.
