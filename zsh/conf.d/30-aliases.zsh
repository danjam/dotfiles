if command -v eza &>/dev/null; then
  alias ll='eza -la --git'
else
  alias ll='ls -lhA'
fi
