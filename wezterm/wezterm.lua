-- Windows 专用配置。日常只需修改本文件和 config/bindings.lua。
-- 安装：把 wezterm.lua、config、colors 一起放到：
--   C:/Users/你的用户名/.config/wezterm/
-- 目录应直接包含 wezterm.lua，不要再套一层 wezterm-config。
-- 保存后自动重载；Ctrl+Shift+F5 也可手动重载。

local wezterm = require('wezterm')
local config = wezterm.config_builder()

-- ── 启动程序 ──────────────────────────────────────────────
-- 默认使用 Windows 自带的 PowerShell，无需额外安装 shell。
config.default_prog = { 'powershell.exe', '-NoLogo' }
-- 安装 PowerShell 7 后，可将上一行改为：
-- config.default_prog = { 'pwsh.exe', '-NoLogo' }
config.launch_menu = {
  { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } },
  { label = 'Command Prompt', args = { 'cmd.exe' } },
  -- { label = 'PowerShell 7', args = { 'pwsh.exe', '-NoLogo' } },
}
-- 只启动本机 Windows shell，不自动添加 WSL 发行版。
config.wsl_domains = {}

-- ── 字体与配色 ────────────────────────────────────────────
-- Windows 需安装对应字体；更换字体只改 family，字号只改 font_size。
config.font = wezterm.font({ family = 'ComicShannsMono Nerd Font', weight = 'Medium' })
config.font_size = 19
config.colors = require('colors.astrodark').scheme
config.window_background_opacity = 1.0 -- 1 为不透明，改成 0.9 可半透明
config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 650

-- ── 窗口与标签栏 ──────────────────────────────────────────
config.initial_cols = 120
config.initial_rows = 30
config.window_padding = { left = 4, right = 4, top = 8, bottom = 8 }
config.adjust_window_size_when_changing_font_size = false
config.enable_scroll_bar = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.tab_max_width = 25
config.show_tab_index_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = true
-- 保留原来的直接关闭行为；如需关闭窗口时确认，改为 'AlwaysPrompt'。
-- Alt+W / Alt+C 的关闭确认单独在 config/bindings.lua 中设置。
config.window_close_confirmation = 'NeverPrompt'

-- 启动时最大化；如果喜欢固定窗口大小，删除下面这段即可。
wezterm.on('gui-startup', function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- ── 常用行为 ──────────────────────────────────────────────
config.automatically_reload_config = true
config.exit_behavior = 'Close'
config.audible_bell = 'Disabled'
config.scrollback_lines = 20000 -- 保留的历史输出行数
config.hyperlink_rules = wezterm.default_hyperlink_rules()

-- ── 快捷键和鼠标 ──────────────────────────────────────────
-- 以本机 Ghostty 的 common + 当前启用的键位为准，禁用额外默认快捷键。
local bindings = require('config.bindings')
config.disable_default_key_bindings = true
config.keys = bindings.keys
config.mouse_bindings = bindings.mouse_bindings

return config
