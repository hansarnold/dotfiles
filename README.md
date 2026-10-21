# dotfiles

Personal configuration files for Linux desktop and terminal tools.

## Included Configs

- `ghostty`: Ghostty terminal settings, split into common config plus macOS/Linux overlays.
- `herdr`: Herdr settings with fish and tmux-style tab shortcuts, without pane splitting.
- `nav`: macOS/Linux keyboard navigation mappings and GNOME screenshot shortcuts.
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

The script links each configured directory into `${XDG_CONFIG_HOME:-$HOME/.config}`. Herdr links only `herdr/config.toml`, keeping sessions, sockets, logs, and plugins machine-local. Existing files or directories are moved aside with a timestamped `.bak-*` suffix before links are created.

Ghostty is split so the same repository can be shared across platforms. `ghostty/config` is the entry point, `ghostty/common` contains shared settings, `ghostty/platform/macos` uses zsh and macOS keybindings, and `ghostty/platform/linux` uses fish and Linux keybindings. During bootstrap, `ghostty/platform.local` is generated as an ignored machine-local selector for the current platform.

To update only Ghostty without touching other configs:

```bash
./bootstrap.sh ghostty
```

To install or update only Herdr:

```bash
./bootstrap.sh herdr
```

Herdr uses `Ctrl+A` as its prefix, followed by `c` for a new tab,
`Ctrl+H`/`Ctrl+L` (or `p`/`n`) to switch tabs, `,` to rename, `&` to close,
`Space` for the terminal navigator, `r` to reload config, and `d` to detach.
Pane splitting and resize shortcuts are disabled. The default shell is
`/usr/bin/fish`; adjust `terminal.default_shell` if fish is installed elsewhere.
After editing the config, run `herdr server reload-config` to apply it.

## Linux nav (Caps Lock layer)

On GNOME with keyd and Ubuntu Tiling Assistant enabled, run:

```bash
/usr/bin/python3 nav/gnome/nav-shortcuts.py
sudo bash nav/keyd/install.sh
```

Tap `Caps Lock` for Escape, or hold it and press the keys below. The positions
match the macOS Karabiner nav configuration:

| Key | GNOME action |
| --- | --- |
| `H` / `L` | Previous / next workspace |
| `J` | Switch between windows of the current application |
| `K` | Toggle the Activities overview |
| `Y` / `O` | Tile to the left / right half |
| `U` / `I` | Focus the previous / next window |
| `P` | Maximize / restore |
| `R` | Restore the size before tiling or maximizing |
| `C` | Center the window on its current monitor |
| `D` | Toggle GNOME accessibility zoom (without key repeat) |
| `Space` | Backspace |

GNOME's same-application window switcher substitutes for macOS App Exposé on `J`.
`C` moves a normal or tiled window without resizing it; use `R` first to restore
a maximized window before centering it. Existing GNOME shortcuts are preserved.
The scripts back up changed GNOME settings under `~/.local/state/dotfiles/backups`
(or `$XDG_STATE_HOME/dotfiles/backups`) and the existing keyd configuration beside
`/etc/keyd/default.conf` before replacing it. Both scripts may be run repeatedly.
They are separate from `bootstrap.sh`, since keyd requires a system-level install.
The keyd installer restarts the service to avoid the
[keyd 2.6.0 reload crash](https://github.com/rvaiya/keyd/issues/1320).

## GNOME screenshot shortcuts

Run this separately inside your GNOME desktop session (requires Flameshot and the
system Python's PyGObject package, `python3-gi` on Ubuntu):

```bash
/usr/bin/python3 nav/gnome/screenshot-shortcuts.py
```

- `Alt+Shift+4`: Run `flameshot gui` to select and annotate a region.
- `Alt+Shift+5`: Open the GNOME screenshot panel. Press `W` or click **Window**, then
  choose a window and press `Enter` to capture it. GNOME saves the image to
  `Pictures/Screenshots` and copies it to the clipboard.

Flameshot 13.3 does not have a native window picker, so window selection uses
GNOME's built-in panel. These settings live in GNOME's gsettings/dconf database;
they are not configuration symlinks managed by `bootstrap.sh`. The script
preserves other custom shortcuts and existing screenshot panel bindings.

## Update

After changing configs:

```bash
git status
git add .
git commit -m "chore: update dotfiles"
git push
```
