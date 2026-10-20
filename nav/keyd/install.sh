#!/usr/bin/env bash
set -euo pipefail

if [[ "$EUID" -ne 0 ]]; then
  printf 'Run this installer with sudo or pkexec.\n' >&2
  exit 1
fi

NAV_KEYD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAV_KEYD_BIN="$(command -v keyd || true)"
if [[ -z "$NAV_KEYD_BIN" && -x /usr/local/bin/keyd ]]; then
  NAV_KEYD_BIN=/usr/local/bin/keyd
fi
if [[ -z "$NAV_KEYD_BIN" ]]; then
  printf 'Install keyd before applying this configuration.\n' >&2
  exit 1
fi

"$NAV_KEYD_BIN" check "$NAV_KEYD_DIR/default.conf"
NAV_KEYD_TARGET=/etc/keyd/default.conf
NAV_KEYD_BACKUP=""
if ! cmp -s "$NAV_KEYD_DIR/default.conf" "$NAV_KEYD_TARGET"; then
  if [[ -e "$NAV_KEYD_TARGET" ]]; then
    NAV_KEYD_BACKUP="$NAV_KEYD_TARGET.bak-$(date +%Y%m%d%H%M%S%N)"
    cp -p -- "$NAV_KEYD_TARGET" "$NAV_KEYD_BACKUP"
    printf 'Previous keyd configuration saved to %s\n' "$NAV_KEYD_BACKUP"
  fi
  install -D -m 644 -- "$NAV_KEYD_DIR/default.conf" "$NAV_KEYD_TARGET"
fi

# keyd 2.6.0 can leave a dangling keyboard pointer after an in-process reload.
# Restart the service instead, then check that the new process stays alive.
# https://github.com/rvaiya/keyd/issues/1320
nav_restart_keyd() {
  systemctl restart keyd || return 1
  sleep 2
  systemctl is-active --quiet keyd
}

if ! nav_restart_keyd; then
  if [[ -n "$NAV_KEYD_BACKUP" ]]; then
    cp -p -- "$NAV_KEYD_BACKUP" "$NAV_KEYD_TARGET"
    nav_restart_keyd
    printf 'Restart failed; previous keyd configuration restored.\n' >&2
  fi
  exit 1
fi
printf 'Caps Lock nav configuration installed and keyd service running.\n'
