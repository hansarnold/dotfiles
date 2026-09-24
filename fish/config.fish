fish_add_path /usr/local/cmake-4.1.1-linux-x86_64/bin

function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

function l
  ls -CF
end
# ~/.config/fish/config.fish

# ==============================================================================
# Proxy configuration for terminal
#
# Usage:
#   proxy on        - Enable the local proxy for the current shell session
#   proxy gnome     - Sync shell proxy variables from GNOME proxy settings
#   proxy off       - Disable proxy for the current shell session
#   proxy status    - Check the current shell and GNOME proxy status
# ==============================================================================
function __proxy_clear
  for name in http_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY ALL_PROXY no_proxy NO_PROXY
    set -e $name
  end
end

function __proxy_set_url --argument-names target scheme host port
  if test -n "$host"; and test -n "$port"; and test "$port" -gt 0 2>/dev/null
    set -l proxy_url "$scheme://$host:$port"
    switch "$target"
      case http
        set -gx http_proxy "$proxy_url"
        set -gx HTTP_PROXY "$proxy_url"
      case https
        set -gx https_proxy "$proxy_url"
        set -gx HTTPS_PROXY "$proxy_url"
      case all
        set -gx all_proxy "$proxy_url"
        set -gx ALL_PROXY "$proxy_url"
    end
    return 0
  end

  return 1
end

function __proxy_sync_from_gnome --argument-names quiet
  if not command -sq gsettings
    return 1
  end

  set -l mode (gsettings get org.gnome.system.proxy mode 2>/dev/null | string trim -c "'")
  if test -z "$mode"
    return 1
  end

  switch "$mode"
    case none
      __proxy_clear
      if test "$quiet" != "--quiet"
        echo "❌ Terminal proxy is OFF."
        echo "   - Synced from GNOME mode: none"
      end
      return 0

    case manual
      set -l http_host (gsettings get org.gnome.system.proxy.http host 2>/dev/null | string trim -c "'")
      set -l http_port (gsettings get org.gnome.system.proxy.http port 2>/dev/null)
      set -l https_host (gsettings get org.gnome.system.proxy.https host 2>/dev/null | string trim -c "'")
      set -l https_port (gsettings get org.gnome.system.proxy.https port 2>/dev/null)
      set -l socks_host (gsettings get org.gnome.system.proxy.socks host 2>/dev/null | string trim -c "'")
      set -l socks_port (gsettings get org.gnome.system.proxy.socks port 2>/dev/null)
      set -l ignore_hosts_raw (gsettings get org.gnome.system.proxy ignore-hosts 2>/dev/null)

      __proxy_clear

      if test -n "$http_host"; and test "$http_port" -gt 0 2>/dev/null
        __proxy_set_url http http "$http_host" "$http_port"
      end

      if test -n "$https_host"; and test "$https_port" -gt 0 2>/dev/null
        __proxy_set_url https http "$https_host" "$https_port"
      else if set -q http_proxy
        set -gx https_proxy "$http_proxy"
        set -gx HTTPS_PROXY "$HTTP_PROXY"
      end

      if test -n "$socks_host"; and test "$socks_port" -gt 0 2>/dev/null
        __proxy_set_url all socks5 "$socks_host" "$socks_port"
      end

      if test -n "$ignore_hosts_raw"
        set -l no_proxy_value (string replace -ra "[\\[\\]']" "" -- $ignore_hosts_raw | string replace -ra ", " "," )
        if test -n "$no_proxy_value"
          set -gx no_proxy "$no_proxy_value"
          set -gx NO_PROXY "$no_proxy_value"
        end
      end

      if test "$quiet" != "--quiet"
        echo "✅ Terminal proxy is ON."
        if set -q http_proxy
          echo "   - HTTP Proxy: $http_proxy"
        end
        if set -q https_proxy
          echo "   - HTTPS Proxy: $https_proxy"
        end
        if set -q all_proxy
          echo "   - SOCKS Proxy: $all_proxy"
        end
        echo "   - Synced from GNOME mode: manual"
      end
      return 0

    case auto
      __proxy_clear
      if test "$quiet" != "--quiet"
        set -l pac_url (gsettings get org.gnome.system.proxy autoconfig-url 2>/dev/null | string trim -c "'")
        echo "⚠️  GNOME proxy mode is auto (PAC)."
        if test -n "$pac_url"
          echo "   - PAC URL: $pac_url"
        end
        echo "   - Shell proxy variables were cleared because PAC is not directly exportable."
      end
      return 0
  end

  return 1
end

function proxy
  # The address and port of your proxy server
  # Clash Verge's default mixed-port is 7897
  set -l proxy_address "http://127.0.0.1:19877"

  switch "$argv[1]"
    case on
      # Use -gx to set a global and exported variable
      # It will be inherited by child processes (like curl, git, etc.)
      __proxy_clear
      set -gx http_proxy "$proxy_address"
      set -gx https_proxy "$proxy_address"
      set -gx all_proxy "$proxy_address"
      set -gx HTTP_PROXY "$proxy_address"
      set -gx HTTPS_PROXY "$proxy_address"
      set -gx ALL_PROXY "$proxy_address"

      # Optional: Add localhost and local network to no_proxy if needed
      # This prevents proxying local traffic, which is usually desired.
      set -gx no_proxy "localhost,127.0.0.1,::1"
      set -gx NO_PROXY "localhost,127.0.0.1,::1"

      echo "✅ Terminal proxy is ON."
      echo "   - HTTP/HTTPS Proxy: $proxy_address"

    case off
      # Use -e to erase the variables
      __proxy_clear
      echo "❌ Terminal proxy is OFF."

    case gnome
      if not __proxy_sync_from_gnome "$argv[2]"
        echo "Failed to read GNOME proxy settings."
        return 1
      end

    case status
      if set -q http_proxy; or set -q https_proxy; or set -q all_proxy
        echo "✅ Terminal proxy is ON."
        if set -q http_proxy
          echo "   - HTTP Proxy: $http_proxy"
        end
        if set -q https_proxy
          echo "   - HTTPS Proxy: $https_proxy"
        end
        if set -q all_proxy
          echo "   - SOCKS Proxy: $all_proxy"
        end
        if set -q NO_PROXY
            echo "   - No Proxy For: $NO_PROXY"
        end
      else
        echo "❌ Terminal proxy is OFF."
      end

      if command -sq gsettings
        set -l gnome_mode (gsettings get org.gnome.system.proxy mode 2>/dev/null | string trim -c "'")
        if test -n "$gnome_mode"
          echo "   - GNOME Mode: $gnome_mode"
        end
      end

    case '*'
      # Display help message for invalid arguments
      echo "Usage: proxy [on | gnome | off | status]"
  end
end

if status is-interactive
  if set -q DBUS_SESSION_BUS_ADDRESS; and command -sq gsettings
    proxy gnome --quiet
  end
end

fish_add_path /usr/local/cuda/bin
set -gx LD_LIBRARY_PATH /usr/local/cuda/lib64 $LD_LIBRARY_PATH
