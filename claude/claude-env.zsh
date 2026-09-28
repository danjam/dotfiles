# Run by Claude Code before each Bash tool command (CLAUDE_ENV_FILE in zsh/conf.d/15-claude.zsh)
# Bash-like behaviour for zsh defaults that break commands Claude writes
# Pass unmatched globs through as text, so `grep --include=*.ts` isn't aborted
setopt NO_NOMATCH
# Don't expand words starting with = to command paths, so `echo =====` works
setopt NO_EQUALS
