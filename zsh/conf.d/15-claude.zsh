# Clean bash shell for CC avoids our zsh aliases and config
export CLAUDE_CODE_SHELL="$(command -v bash)"
# Disable feedback survey prompt
export CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY="1"
# On-demand MCP tool discovery instead of loading all tools upfront
export ENABLE_TOOL_SEARCH="true"
# Use full 24-bit color in tmux instead of 256-color fallback
export CLAUDE_CODE_TMUX_TRUECOLOR="1"
