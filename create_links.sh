#!/bin/bash

# This script creates symbolic links from the agent configuration folders
# to the corresponding files in this repository.

# Link Gemini settings
ln -sf /home/dp/.ai/gemini_conf/settings.json /home/dp/.gemini/settings.json

# Link Claude settings
ln -sf /home/dp/.ai/claude_conf/settings.json /home/dp/.claude/settings.json

# Link CLAUDE.md
ln -sf /home/dp/.ai/CLAUDE.md /home/dp/.claude/CLAUDE.md

# Link GEMINI.md
ln -sf /home/dp/.ai/GEMINI.md /home/dp/.gemini/GEMINI.md