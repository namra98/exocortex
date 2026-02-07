#!/bin/bash
# Exocortex — One-line installer (Linux/macOS)
# Usage: curl -fsSL https://raw.githubusercontent.com/namra98/exocortex/main/install.sh | bash
# Or run locally: ./install.sh

set -e

CLONE_PATH="${1:-$HOME/exocortex}"
SKILL_DIR="$HOME/.copilot/skills/exocortex"
SKILL_FILE="$SKILL_DIR/SKILL.md"

# Step 1: Clone repo if not already present
if [ -f "$CLONE_PATH/NOTES-SKILL.md" ]; then
    echo "Repo already exists at $CLONE_PATH - pulling latest..."
    cd "$CLONE_PATH" && git pull --quiet
else
    echo "Cloning exocortex to $CLONE_PATH..."
    git clone https://github.com/namra98/exocortex.git "$CLONE_PATH" 2>/dev/null
    if [ ! -f "$CLONE_PATH/NOTES-SKILL.md" ]; then
        echo "ERROR: Clone failed. Check git access to namra98/exocortex." >&2
        exit 1
    fi
fi

REPO_ROOT="$(cd "$CLONE_PATH" && pwd)"

# Step 2: Create skill directory
mkdir -p "$SKILL_DIR"

# Step 3: Generate SKILL.md from template
TEMPLATE_PATH="$REPO_ROOT/skill-template.md"
if [ ! -f "$TEMPLATE_PATH" ]; then
    echo "ERROR: skill-template.md not found in repo." >&2
    exit 1
fi
sed "s|{{REPO_ROOT}}|$REPO_ROOT|g" "$TEMPLATE_PATH" > "$SKILL_FILE"

echo ""
echo "Exocortex installed!"
echo "  Repo:  $REPO_ROOT"
echo "  Skill: $SKILL_FILE"
echo ""
echo "Restart Copilot CLI or run /skills reload to activate."
