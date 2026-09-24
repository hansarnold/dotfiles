# dotfiles

Personal configuration files for Linux desktop and terminal tools.

## Included Configs

- `fish`: Fish shell config, functions, completions, and the installed Fisher/Tide plugins.
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

## Fish

Link only the Fish configuration with `./bootstrap.sh fish`. It includes the
existing proxy helpers, Yazi wrapper (`y`), tmux shortcut (`t`), and plugin files.
`fish_variables*` stays local and is ignored by Git. The current Tide preferences
are saved in `fish/conf.d/tide-settings.fish` as defaults for a new machine;
existing preferences take priority. Plugins are listed in `fish/fish_plugins`
and can be refreshed with `fisher update` from Fish.

The `geoip` function uses [IP.SB's GeoIP JSON API](https://ip.sb/api/) and requires
`curl` and `jq`:

```fish
geoip                     # Public IP, location, ISP, ASN, timezone, coordinates
geoip --json              # Full formatted JSON response
geoip --json | jq -r .ip   # Extract a JSON field
geoip 1.1.1.1             # Look up a specific IPv4 or IPv6 address
geoip -4                  # IPv4 endpoint
geoip -6                  # IPv6 endpoint (requires IPv6 connectivity)
```

Requests follow the current proxy environment, including the existing `proxy`
helper. With a proxy enabled, an own-IP lookup describes the proxy exit address.
Missing location fields display `-`; network/HTTP errors or invalid JSON return
a nonzero status. Connect and total timeouts are 5 and 15 seconds respectively.

## Update

After changing configs:

```bash
git status
git add .
git commit -m "chore: update dotfiles"
git push
```
