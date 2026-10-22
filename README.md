# dotfiles

Personal configuration files for Linux desktop and terminal tools.

## Included Configs

- `fish`: Fish helper functions; `h` launches or attaches to Herdr.
- `ghostty`: Ghostty terminal settings, split into common config plus macOS/Linux overlays.
- `herdr`: Herdr settings with fish and tmux-style tab shortcuts, without pane splitting.
- `kitty`: Kitty terminal settings mirrored from Ghostty (font, theme, keybindings).
- `nvim`: Neovim configuration based on AstroNvim.
- `tmux`: tmux config split into `conf.d` modules, with a plugin manager helper.
- `yazi`: Yazi theme and flavor configuration.
- `zed`: Zed editor settings and keybindings.

`wezterm` is present as a placeholder only and is skipped by the bootstrap script until real config files are added.

## Install

Clone the repository into `~/.config/dotfiles`, then run:

```bash
./bootstrap.sh
```

The script links each configured directory into `${XDG_CONFIG_HOME:-$HOME/.config}`. Fish links only `fish/functions/h.fish`, preserving local shell configuration. Herdr links only `herdr/config.toml`, keeping sessions, sockets, logs, and plugins machine-local. Existing files or directories are moved aside with a timestamped `.bak-*` suffix before links are created.

Ghostty is split so the same repository can be shared across platforms. `ghostty/config` is the entry point, `ghostty/common` contains shared settings, `ghostty/platform/macos` uses zsh and macOS keybindings, and `ghostty/platform/linux` uses fish and Linux keybindings. During bootstrap, `ghostty/platform.local` is generated as an ignored machine-local selector for the current platform.

To update only Ghostty without touching other configs:

```bash
./bootstrap.sh ghostty
```

To install or update Herdr and its fish shortcut:

```bash
./bootstrap.sh fish herdr
```

In fish, run `h` instead of `herdr`; arguments are forwarded unchanged.

Herdr uses `Ctrl+A` as its prefix, followed by `c` for a new tab,
`Ctrl+H`/`Ctrl+L` (or `p`/`n`) to switch tabs, `,` to rename, `&` to close,
`w` or `Space` for the terminal navigator, `g` for workspace navigation,
`r` to reload config, and `d` to detach. Settings keep the default `prefix+s`.
Pane splitting and resize shortcuts are disabled. The default shell is
`/usr/bin/fish`; adjust `terminal.default_shell` if fish is installed elsewhere.
After editing the config, run `herdr server reload-config` to apply it.

## Update

After changing configs:

```bash
git status
git add .
git commit -m "chore: update dotfiles"
git push
```
