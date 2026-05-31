# WSL opens in /mnt/c/Users/... on login — jump to home
[[ -o login && "$PWD" = /mnt/* ]] && cd ~

HISTSIZE=50000
SAVEHIST=50000

# Timestamps and duration per command
setopt EXTENDED_HISTORY
# Write to history immediately, not on shell exit
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
# Prefix command with space to keep it out of history
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
# Show expanded history command before running it
setopt HIST_VERIFY
# Enables ^, #, ~ as glob operators
setopt EXTENDED_GLOB
setopt NOBEEP
# Sort filenames numerically: file1, file2, file10 not file1, file10, file2
setopt NUMERIC_GLOB_SORT

# Bulk rename: zmv '(*).jpeg' '$1.jpg'
autoload -U zmv
