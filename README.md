# dotfiles

Personal configuration files for Linux desktop and terminal tools.

## Included Configs

- `ghostty`: Ghostty terminal settings.
- `nvim`: Neovim configuration based on AstroNvim.
- `tmux`: tmux config split into `conf.d` modules, with a plugin manager helper.
- `yazi`: Yazi theme and flavor configuration.
- `zed`: Zed editor settings and keybindings.

`kitty` and `wezterm` are present as placeholders only and are skipped by the bootstrap script until real config files are added.

## Install

Clone the repository into `~/.config/dotfiles`, then run:

```bash
./bootstrap.sh
```

The script links each configured directory into `${XDG_CONFIG_HOME:-$HOME/.config}`. Existing files or directories are moved aside with a timestamped `.bak-*` suffix before links are created.

## Update

After changing configs:

```bash
git status
git add .
git commit -m "chore: update dotfiles"
git push
```

