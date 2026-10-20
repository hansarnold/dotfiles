#!/usr/bin/python3
"""Apply screenshot shortcuts in the current user's GNOME desktop session."""

import shutil

from gi.repository import Gio


def main():
    if shutil.which("flameshot") is None:
        raise SystemExit("Install Flameshot before applying its shortcut.")

    media_keys = Gio.Settings.new("org.gnome.settings-daemon.plugins.media-keys")
    shell_keys = Gio.Settings.new("org.gnome.shell.keybindings")
    paths = media_keys.get_strv("custom-keybindings")
    path = "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/"
    custom = Gio.Settings.new_with_path(
        "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding", path
    )
    custom.delay()
    custom.set_string("name", "Flameshot")
    custom.set_string("command", "flameshot gui")
    custom.set_string("binding", "<Alt><Shift>4")
    custom.apply()
    if path not in paths:
        media_keys.set_strv("custom-keybindings", [*paths, path])

    # GNOME's native panel supports window selection with W or the Window button.
    # Keep existing panel shortcuts (including Print) and unrelated custom entries.
    panel_keys = shell_keys.get_strv("show-screenshot-ui")
    if "<Alt><Shift>5" not in panel_keys:
        shell_keys.set_strv("show-screenshot-ui", [*panel_keys, "<Alt><Shift>5"])
    Gio.Settings.sync()
    print("Alt+Shift+4: Flameshot region capture and annotation")
    print("Alt+Shift+5: GNOME screenshot panel; press W to select a window")


if __name__ == "__main__":
    main()
