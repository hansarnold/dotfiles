-- Windows 快捷键：对应本机 Ghostty 的实际操作习惯。
-- key 是按键，mods 是修饰键（用 | 连接），action 是执行的操作。
-- Ctrl/Alt 的 h/j/k/l 不在这里绑定，直接交给终端中的程序。
local wezterm = require('wezterm')
local act = wezterm.action

local keys = {
  -- 复制 / 粘贴（保留 Ctrl+C 给命令行中断操作）
  { key = 'C', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
  { key = 'V', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },

  -- 命令行编辑：使用 Windows 按键表达 Ghostty 的行首 / 行尾 / 删除至行首。
  -- Alt+Backspace 对应 PowerShell 默认 PSReadLine 的 Ctrl+Home；其他程序自行解释。
  { key = 'LeftArrow', mods = 'ALT', action = act.SendKey({ key = 'Home', mods = 'NONE' }) },
  { key = 'RightArrow', mods = 'ALT', action = act.SendKey({ key = 'End', mods = 'NONE' }) },
  { key = 'Backspace', mods = 'ALT', action = act.SendKey({ key = 'Home', mods = 'CTRL' }) },

  -- 标签页：新建 / 关闭整个标签页 / 上一个 / 下一个
  -- confirm = true 可在关闭标签页或分屏前显示确认提示。
  { key = 't', mods = 'ALT', action = act.SpawnTab('DefaultDomain') },
  { key = 'w', mods = 'ALT', action = act.CloseCurrentTab({ confirm = false }) },
  { key = '[', mods = 'ALT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'ALT', action = act.ActivateTabRelative(1) },
  {
    key = '0',
    mods = 'ALT',
    action = act.PromptInputLine({
      description = '标签页名称（留空恢复自动标题）',
      action = wezterm.action_callback(function(window, _pane, line)
        if line ~= nil then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  -- 窗口和分屏：Alt+\ 向右分屏，Alt+Ctrl+\ 向下分屏。
  -- WezTerm 的 Horizontal 是左右排列，Vertical 是上下排列。
  { key = 'n', mods = 'ALT', action = act.SpawnWindow },
  { key = '\\', mods = 'ALT', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
  { key = '\\', mods = 'ALT|CTRL', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
  { key = 'c', mods = 'ALT', action = act.CloseCurrentPane({ confirm = false }) },
  { key = 'Enter', mods = 'ALT', action = act.TogglePaneZoomState },
  -- Ctrl+Shift+[ / ]：按顺序切换分屏。字符使用美式键盘按下 Shift 后的值。
  { key = '{', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Prev') },
  { key = '}', mods = 'CTRL|SHIFT', action = act.ActivatePaneDirection('Next') },
  -- Ghostty 的 Alt+Ctrl+R（均分分屏）没有对应的 WezTerm 原生动作，暂不绑定。
  -- 需要调整大小时，直接用鼠标拖动分屏之间的分隔线。

  -- 滚动：与 Ghostty 一致，PageUp / PageDown 用于终端历史输出。
  { key = 'PageUp', mods = 'NONE', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'NONE', action = act.ScrollByPage(1) },
  { key = 'Home', mods = 'CTRL|SHIFT', action = act.ScrollToTop },
  { key = 'End', mods = 'CTRL|SHIFT', action = act.ScrollToBottom },

  -- 字号：Ctrl+Shift+= / - / 0；+、_、) 是这些键按下 Shift 后的字符。
  { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
  { key = '_', mods = 'CTRL|SHIFT', action = act.DecreaseFontSize },
  { key = ')', mods = 'CTRL|SHIFT', action = act.ResetFontSize },

  -- 工具：全屏 / 命令面板 / 重载配置 / 调试面板
  -- 命令面板中也可搜索启动菜单等未单独绑定快捷键的操作。
  { key = 'F11', mods = 'NONE', action = act.ToggleFullScreen },
  { key = 'P', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette },
  { key = 'F5', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },
  { key = 'F6', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay },
}

-- 保留默认的选择、拖动和滚轮行为；选中后复制到 Windows 剪贴板。
local mouse_bindings = {}
for streak = 1, 3 do
  table.insert(mouse_bindings, {
    event = { Up = { streak = streak, button = 'Left' } },
    mods = 'NONE',
    action = act.CompleteSelection('Clipboard'),
  })
end
table.insert(mouse_bindings, {
  event = { Up = { streak = 1, button = 'Left' } },
  mods = 'CTRL',
  action = act.OpenLinkAtMouseCursor,
})

return { keys = keys, mouse_bindings = mouse_bindings }
