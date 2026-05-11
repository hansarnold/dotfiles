# dotfiles

Personal configuration files for Linux desktop and terminal tools.

## Included Configs

- `ghostty`: Ghostty terminal settings, split into common config plus macOS/Linux overlays.
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

Ghostty is split so the same repository can be shared across platforms. `ghostty/config` is the entry point, `ghostty/common` contains shared settings, `ghostty/platform/macos` uses zsh and macOS keybindings, and `ghostty/platform/linux` uses fish and Linux keybindings. During bootstrap, `ghostty/platform.local` is generated as an ignored machine-local selector for the current platform.

To update only Ghostty without touching other configs:

```bash
./bootstrap.sh ghostty
```

## Update

After changing configs:

```bash
git status
git add .
git commit -m "chore: update dotfiles"
git push
```
