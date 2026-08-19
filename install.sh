#!/usr/bin/env bash
# Installs the a11y-audit Claude Code skill into the current project.
# Usage (from your project's repo root):
#   curl -sL https://raw.githubusercontent.com/tushar33/a11y-audit-skill/main/install.sh | bash
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/tushar33/a11y-audit-skill/main"
DEST="skills/a11y-audit"

if [ -f "$DEST/a11y-audit.md" ]; then
  echo "skills/a11y-audit already exists here — remove it first if you want to reinstall." >&2
  exit 1
fi

mkdir -p "$DEST" .claude/commands

for f in a11y-audit.md categories.md README.md; do
  curl -sL "$REPO_RAW/skills/a11y-audit/$f" -o "$DEST/$f"
done

# Only install the empty project-checklist stub if this project doesn't
# already have one from a previous run.
if [ ! -f "$DEST/project-checklist.md" ]; then
  curl -sL "$REPO_RAW/skills/a11y-audit/project-checklist.md" -o "$DEST/project-checklist.md"
fi

ln -sf "../../$DEST/a11y-audit.md" .claude/commands/a11y-audit.md

echo "Installed. Run /a11y-audit in Claude Code to start your first audit."
