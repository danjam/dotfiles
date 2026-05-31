#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

failed=0

if command -v shellcheck &>/dev/null; then
  echo "Running shellcheck on bash files..."
  shellcheck install.sh lint.sh || failed=1
else
  echo "shellcheck not found, skipping bash lint"
fi

echo "Running zsh syntax check..."
zsh -n zsh/.zshrc || failed=1
for f in zsh/conf.d/*.zsh; do
  zsh -n "$f" || failed=1
done

if [ "$failed" -ne 0 ]; then
  echo "Lint failed"
  exit 1
fi

echo "Lint passed"
