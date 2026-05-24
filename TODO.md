# TODO

- [x] ~~Install Consolas Nerd Font on Windows~~ No longer needed — using plain unicode
- [x] ~~Pick an Oh My Posh theme~~ Built custom theme (omp/danjam.omp.json)
- [x] Install Oh My Posh
- [ ] Create palette file (05-palette.zsh) based on chosen theme colours
- [ ] Customise syntax highlighting colours using palette
- [ ] Customise autosuggestion colour using palette 
- [ ] Configure fzf colours using palette
- [ ] Configure FZF_DEFAULT_OPTS layout
- [ ] Configure fzf-tab previews

## Notes

### Oh My Posh

OMP is a prompt theme engine that works alongside Oh My Zsh. OMP handles the prompt, omz keeps handling plugins. To integrate: set `ZSH_THEME=""` in `.zshrc` and add `eval "$(oh-my-posh init zsh --config <theme>)"` after the omz source line. Install via `curl -s https://ohmyposh.dev/install.sh | bash -s` (installs to `~/.local/bin`). Requires a Nerd Font installed on the Windows side (Windows Terminal renders the glyphs). Theme gallery: ohmyposh.dev/docs/themes

### Palette file

Create `zsh/conf.d/05-palette.zsh` defining shell variables (e.g. `THEME_RED="#E06C75"`) sourced before other conf.d files. fzf colours in `45-fzf.zsh` and syntax highlighting in `55-highlighting.zsh` should reference these variables. OMP reads its own JSON/TOML theme file separately — duplicate the hex values there. The palette file is the canonical reference; if colours change, update it and the OMP theme file.

### fzf layout

`FZF_DEFAULT_OPTS` in `45-fzf.zsh` controls layout (height, border style, list direction, info position). No values chosen yet — experiment before committing.

### fzf-tab previews

Add `zstyle` config for fzf-tab previews. Use `$realpath` variable provided by fzf-tab. Fall back gracefully: try bat then cat for files, try eza then ls for directories. Same pattern as the existing `FZF_CTRL_T_OPTS` and `FZF_ALT_C_OPTS` fallbacks.

### Syntax highlighting and autosuggestions

`ZSH_HIGHLIGHT_STYLES` in `55-highlighting.zsh` controls per-token colours (commands, builtins, aliases, strings, etc.). `ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE` controls the ghost text colour. Both should use palette variables once the palette file exists.
