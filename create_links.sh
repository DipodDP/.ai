#!/bin/bash

# This script creates symbolic links from the agent configuration folders
# to the corresponding files in this repository.
#
# Works on both Linux and macOS, for any user

# Detect home directory
HOME_DIR="${HOME:-$(eval echo ~$USER)}"

# Ensure target directories exist
mkdir -p "$HOME_DIR/.gemini"
mkdir -p "$HOME_DIR/.claude"

# Link Gemini settings
ln -sf "$HOME_DIR/.ai/gemini_conf/settings.json" "$HOME_DIR/.gemini/settings.json"
echo "✓ Linked: ~/.gemini/settings.json -> ~/.ai/gemini_conf/settings.json"

# Link Claude settings
ln -sf "$HOME_DIR/.ai/claude_conf/settings.json" "$HOME_DIR/.claude/settings.json"
echo "✓ Linked: ~/.claude/settings.json -> ~/.ai/claude_conf/settings.json"

# Link CLAUDE.md
ln -sf "$HOME_DIR/.ai/CLAUDE.md" "$HOME_DIR/.claude/CLAUDE.md"
echo "✓ Linked: ~/.claude/CLAUDE.md -> ~/.ai/CLAUDE.md"

# Link GEMINI.md
ln -sf "$HOME_DIR/.ai/GEMINI.md" "$HOME_DIR/.gemini/GEMINI.md"
echo "✓ Linked: ~/.gemini/GEMINI.md -> ~/.ai/GEMINI.md"

# Link skills from ~/.agents/skills (its own git repo) into ~/.claude/skills
if [ -d "$HOME_DIR/.agents/skills" ]; then
  mkdir -p "$HOME_DIR/.claude/skills"
  for skill in "$HOME_DIR/.agents/skills"/*/; do
    name="$(basename "$skill")"
    ln -sfn "../../.agents/skills/$name" "$HOME_DIR/.claude/skills/$name"
  done
  echo "✓ Linked: ~/.claude/skills/* -> ~/.agents/skills/*"
else
  echo "⚠ Skipped skills: ~/.agents/skills not found (clone your .agents repo first)"
fi

echo ""
echo "All AI configuration links created successfully!"