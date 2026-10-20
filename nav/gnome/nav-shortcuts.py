#!/usr/bin/python3
"""Configure GNOME actions used by the Caps Lock nav layer in ../keyd/."""

from datetime import datetime
import json
import os
from pathlib import Path

from gi.repository import Gio


BINDINGS = {
    "org.gnome.desktop.wm.keybindings": {
        "switch-to-workspace-left": "<Control><Alt>Left",
        "switch-to-workspace-right": "<Control><Alt>Right",
        "switch-group": "<Control><Super>j",
        "switch-windows-backward": "<Control><Super>u",
        "switch-windows": "<Control><Super>i",
    },
    "org.gnome.shell.keybindings": {"toggle-overview": "<Control><Super>k"},
    "org.gnome.shell.extensions.tiling-assistant": {
        "tile-left-half": "<Super>Left",
        "tile-right-half": "<Super>Right",
        "tile-maximize": "<Super>Up",
        "restore-window": "<Control><Super>r",
        "center-window": "<Control><Super>c",
    },
    "org.gnome.settings-daemon.plugins.media-keys": {"magnifier": "<Alt><Super>8"},
}


def main():
    source = Gio.SettingsSchemaSource.get_default()
    for schema in BINDINGS:
        if source.lookup(schema, True) is None:
            raise SystemExit(f"Missing GNOME settings schema: {schema}")

    settings = {schema: Gio.Settings.new(schema) for schema in BINDINGS}
    changes = []
    backup = {}
    for schema, bindings in BINDINGS.items():
        for key, accelerator in bindings.items():
            current = settings[schema].get_strv(key)
            if accelerator in current:
                continue
            if not settings[schema].is_writable(key):
                raise SystemExit(f"Setting is not writable: {schema} {key}")
            backup.setdefault(schema, {})[key] = current
            changes.append((schema, key, [*current, accelerator]))

    if changes:
        state_home = Path(os.environ.get("XDG_STATE_HOME", Path.home() / ".local/state"))
        backup_dir = state_home / "dotfiles/backups"
        backup_dir.mkdir(parents=True, exist_ok=True)
        backup_path = backup_dir / ("nav-" + datetime.now().strftime("%Y%m%d-%H%M%S-%f") + ".json")
        backup_path.write_text(json.dumps(backup, indent=2) + "\n")
        print(f"Previous GNOME shortcuts saved to {backup_path}")
        for schema, key, accelerators in changes:
            if not settings[schema].set_strv(key, accelerators):
                raise SystemExit(f"Could not update {schema} {key}")
        Gio.Settings.sync()

    print("GNOME nav shortcuts configured; existing shortcuts preserved.")
    print("Run nav/keyd/install.sh as root to activate Caps Lock chords.")
    print("Ubuntu Tiling Assistant must be enabled for Y/O/P/R/C.")


if __name__ == "__main__":
    main()
