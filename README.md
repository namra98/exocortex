# 🧠 Exocortex

Personal knowledge management system designed for AI CLI assistants (GitHub Copilot CLI, Claude CLI, etc.).

Capture ideas, log daily activity, manage tasks, and generate weekly/monthly recaps — all in markdown, operated via natural language.

## Prerequisites

- [Git](https://git-scm.com/)
- [GitHub Copilot CLI](https://docs.github.com/en/copilot/github-copilot-in-the-cli) (or any AI CLI that supports skill files)

## Quick Start

**One-line install** (clones repo + installs Copilot CLI skill):

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/namra98/exocortex/main/install.ps1 | iex
```

**macOS / Linux (bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/namra98/exocortex/main/install.sh | bash
```

Restart Copilot CLI or run `/skills reload`, then:

```
> save idea: build a chrome extension for tab management
> log: finished the API refactor, merged PR #42
> add task: review design doc for auth service
> show my tasks
> how was my week?
> weekly recap
```

## What Gets Installed

The install script:
1. Clones this repo to `~/exocortex` (customizable path)
2. Creates `~/.copilot/skills/exocortex/SKILL.md` — a lightweight skill file pointing to the repo's full operating manual

The skill auto-detects your repo path, so it works regardless of where you clone it.

**Custom clone path:**
```powershell
# Windows
.\install.ps1 -ClonePath "C:\my\notes"
```
```bash
# macOS / Linux
./install.sh ~/my/notes
```

## Structure

```
exocortex/
├── daily/YYYY/MM/YYYY-MM-DD.md   # Daily logs (one per day)
├── ideas/<slug>.md                 # Idea files (one per idea)
├── tasks/active.md                 # Task board (categorized)
├── tasks/archive.md                # Completed tasks
├── weekly/YYYY-WNN.md              # Weekly recaps (generated)
├── monthly/YYYY-MM.md              # Monthly recaps (generated)
├── config.md                       # User preferences
├── NOTES-SKILL.md                  # Full AI operating manual
├── install.ps1                     # Installer (Windows)
└── install.sh                      # Installer (macOS/Linux)
```

## Multi-Machine Setup

Run the same one-liner on each machine. The installer clones to `~/exocortex` (or pulls latest if already cloned) and generates a machine-local skill file. All machines auto-sync via git — the AI agent pulls before reading and pushes after writing.

Merge conflicts are handled automatically per file type (see `NOTES-SKILL.md` for the full merge strategy).

## License

MIT
