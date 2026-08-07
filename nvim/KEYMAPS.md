# Neovim 快捷键速查

这份文档对应当前 `~/.config/dotfiles/nvim` 中的 AstroNvim 配置。

## 约定与自助查询

- `<Leader>` 是 `<Space>`。
- `<LocalLeader>` 是 `,`。
- `<C-x>` 表示按住 `Ctrl` 再按 `x`。
- `<S-x>` 表示按住 `Shift` 再按 `x`。
- 在普通模式按 `<Space>` 后稍等，WhichKey 会显示可用的后续按键。
- `<Space>fk` 可以搜索当前已经注册的快捷键。
- Neo-tree 文件树中按 `?` 可以查看文件树当前上下文的完整快捷键。

## 最值得先记住的操作

| 按键 | 操作 |
| --- | --- |
| `<Space><Space>` | 查找文件，等同于 `<Space>ff` |
| `<Space>fw` | 在项目中搜索文本 |
| `<Space>fc` | 搜索光标下的单词 |
| `<Space>fl` | 搜索当前文件中的行 |
| `<Space>fu` | 可视化查看和恢复撤销历史 |
| `<Space>e` | 打开或关闭文件树 |
| `<Space>o` | 在文件树和编辑窗口之间切换焦点 |
| `<Space>bb` | 从顶部 Buffer 列表中选择文件 |
| `<Space>go` | 在 GitHub 等远端页面打开当前文件或选中行 |
| `gx` | 用系统默认程序打开光标下的 URL 或文件 |
| `<Space>fk` | 搜索所有快捷键 |

## 剪贴板与当前文件路径

配置已启用 `clipboard=unnamedplus`，所以默认寄存器与 macOS 系统剪贴板相连：

| 按键 | 操作 |
| --- | --- |
| `yy` | 复制当前行到系统剪贴板 |
| Visual 模式下 `y` | 复制选中内容到系统剪贴板 |
| `p` / `P` | 从系统剪贴板向后／向前粘贴 |
| `"0p` | 粘贴最近一次 yank 的内容，不受后续删除操作影响 |
| Insert 模式下 `<C-r>%` | 在当前位置插入当前文件名或路径 |

复制当前文件的不同路径形式：

```vim
:let @+ = expand('%:p')     " 绝对路径
:let @+ = expand('%:.')     " 相对当前工作目录的路径
:let @+ = expand('%:~')     " 以 ~ 表示 HOME 的路径
:let @+ = expand('%:t')     " 仅文件名
:let @+ = expand('%:p:h')   " 当前文件所在目录
```

更方便的交互方式：按 `<Space>e` 进入 Neo-tree，把光标停在文件上，按大写 `Y`，然后选择 `PATH`、`PATH (CWD)`、`FILENAME` 等格式。

> Neo-tree 中大写 `Y` 是把路径文本复制到系统剪贴板；小写 `y` 是复制文件节点，供之后用 `p` 粘贴文件。

## 文件与基本编辑

| 按键 | 操作 |
| --- | --- |
| `<Space>w` | 保存文件 |
| `<C-s>` | 强制保存 |
| `<Space>n` | 新建空文件 |
| `<Space>R` | 重命名当前文件，并通知支持重命名的 LSP |
| `<Space>c` | 关闭当前 Buffer |
| `<Space>C` | 强制关闭当前 Buffer |
| `<Space>q` | 关闭当前窗口 |
| `<Space>Q` | 退出 AstroNvim |
| `<Space>/` | 注释或取消注释当前行 |
| `gcc` | 注释或取消注释当前行 |
| `gc` 加动作 | 注释一个范围，例如 `gcap` 注释一个段落 |
| `gco` / `gcO` | 在下方／上方新增注释行 |
| `]<Space>` / `[<Space>` | 在下方／上方插入空行 |
| `gf` | 打开光标下的文件路径 |
| `gF` | 打开光标下的 `文件:行号` |

## 文件搜索

| 按键 | 操作 |
| --- | --- |
| `<Space>ff` | 查找文件；在 Git 仓库中会包含隐藏文件 |
| `<Space>fF` | 查找所有文件，包括隐藏和被忽略的文件 |
| `<Space>fg` | 只查找 Git 管理的文件 |
| `<Space>fw` | 在项目文件中搜索文本 |
| `<Space>fW` | 搜索所有文件，包括隐藏和被忽略的文件 |
| `<Space>fc` | 搜索光标下的单词 |
| `<Space>fl` | 搜索当前 Buffer 的行 |
| `<Space>fb` | 搜索已打开的 Buffer |
| `<Space>fs` | 综合搜索 Buffer、最近文件和普通文件 |
| `<Space>fo` | 搜索最近打开的文件 |
| `<Space>fO` | 搜索当前工作目录中的最近文件 |
| `<Space>fp` | 搜索最近项目 |
| `<Space>f'` | 搜索 marks |
| `<Space>fr` | 查看寄存器并选择内容 |
| `<Space>fu` | 查看撤销历史 |
| `<Space>fC` | 搜索 Neovim 命令 |
| `<Space>fh` | 搜索帮助文档 |
| `<Space>fm` | 搜索 man page |
| `<Space>fn` | 搜索历史通知 |
| `<Space>f<Enter>` | 恢复上一次搜索 |
| `<Space>fa` | 查找 AstroNvim 配置文件 |
| `<Space>fT` | 搜索 `TODO`、`FIXME` 等注释 |
| `]T` / `[T` | 跳到下一个／上一个 TODO 注释 |

## Neo-tree 文件树

先按 `<Space>e` 打开文件树，或按 `<Space>o` 在文件树与编辑窗口之间切换。

### 浏览与打开

| 按键 | 操作 |
| --- | --- |
| `<Enter>` / `l` | 展开目录或打开文件 |
| `h` | 收起目录或回到父节点 |
| `<BS>` | 返回上级目录 |
| `.` | 把当前目录设为文件树根目录 |
| `P` | 浮动预览文件 |
| `O` | 用系统默认程序打开文件 |
| `s` / `S` | 垂直／水平分屏打开 |
| `t` | 在新 Tab 中打开 |
| `w` | 选择目标窗口后打开 |
| `q` | 关闭文件树 |
| `[b` / `]b` | 切换 File、Buffers、Git、Diagnostics 数据源 |
| `<` / `>` | 上一个／下一个数据源 |

### 文件管理

| 按键 | 操作 |
| --- | --- |
| `a` / `A` | 新建文件／目录 |
| `r` | 重命名文件或目录 |
| `b` | 只重命名 basename，保留扩展名 |
| `d` | 删除文件或目录 |
| `y` / `x` / `p` | 复制／剪切／粘贴文件节点 |
| `<C-r>` | 清除 Neo-tree 文件剪贴板 |
| `c` / `m` | 复制／移动到输入的目标路径 |
| `Y` | 选择一种格式，将路径复制到系统剪贴板 |
| `i` | 显示文件详细信息 |
| `R` | 刷新文件树 |

### 过滤与目录内搜索

| 按键 | 操作 |
| --- | --- |
| `H` | 显示或隐藏隐藏文件 |
| `/` | 在当前文件树内模糊过滤 |
| `<C-x>` | 清除过滤条件 |
| `ff` / `fF` | 在所选目录查找文件／查找全部文件 |
| `fw` / `fW` | 在所选目录搜索文本／搜索全部文本 |
| `[g` / `]g` | 跳到上一个／下一个 Git 修改文件 |

### 从所选目录打开终端

| 按键 | 操作 |
| --- | --- |
| `Tf` | 在所选目录打开浮动终端 |
| `Th` | 在所选目录打开水平终端 |
| `Tv` | 在所选目录打开垂直终端 |

## Buffer、窗口与 Tab

| 按键 | 操作 |
| --- | --- |
| `]b` / `[b` | 下一个／上一个 Buffer |
| `>b` / `<b` | 把当前 Buffer 标签向右／向左移动 |
| `<Space>bb` | 从顶部 Buffer 列表选择 Buffer |
| `<Space>bd` | 从顶部列表选择并关闭 Buffer |
| `<Space>bc` | 关闭除当前以外的所有 Buffer |
| `<Space>bC` | 关闭所有 Buffer |
| `<Space>bl` / `<Space>br` | 关闭当前 Buffer 左侧／右侧的 Buffer |
| `<Space>b\|` | 选择一个 Buffer 并垂直分屏打开 |
| `<Space>b\` | 选择一个 Buffer 并水平分屏打开 |
| `\|` / `\` | 新建垂直／水平分屏 |
| `<C-h/j/k/l>` | 移动到左／下／上／右窗口 |
| `<C-Left/Down/Up/Right>` | 调整窗口大小 |
| `]t` / `[t` | 下一个／上一个 Tab |

Buffer 排序位于 `<Space>bs`：

- `<Space>bse`：按扩展名。
- `<Space>bsr`：按相对路径。
- `<Space>bsp`：按完整路径。
- `<Space>bsm`：按修改状态。
- `<Space>bsi`：按 Buffer 编号。

## LSP 与代码导航

这些按键只会在当前文件成功连接对应语言服务器时出现。

| 按键 | 操作 |
| --- | --- |
| `K` | 查看光标下符号的悬浮文档 |
| `gd` | 跳转到定义 |
| `gD` | 跳转到声明 |
| `gy` | 跳转到类型定义 |
| `grr` / `<Space>lR` | 查找引用 |
| `grn` / `<Space>lr` | 重命名符号 |
| `gra` / `<Space>la` | Code Action |
| `gK` / `<Space>lh` | 函数签名帮助 |
| `<Space>lA` | Source Action，例如整理 imports |
| `<Space>lf` | 格式化当前文件或 Visual 选区 |
| `<Space>ls` | 搜索当前文件符号 |
| `<Space>lG` | 搜索 Workspace 符号 |
| `<Space>ll` / `<Space>lL` | 刷新／运行 CodeLens |
| `<Space>lw` | C/C++ 源文件与头文件之间切换 |

当前配置已启用保存时自动格式化。相关开关：

| 按键 | 操作 |
| --- | --- |
| `<Space>uf` | 开关当前 Buffer 的自动格式化 |
| `<Space>uF` | 全局开关自动格式化 |
| `<Space>uh` | 开关当前 Buffer 的 Inlay Hints |
| `<Space>uH` | 全局开关 Inlay Hints |
| `<Space>u?` | 开关自动签名帮助 |
| `<Space>uL` | 开关 CodeLens |
| `<Space>uY` | 开关当前 Buffer 的 LSP 语义高亮 |

## Diagnostics

| 按键 | 操作 |
| --- | --- |
| `gl` / `<Space>ld` | 显示光标附近的诊断信息 |
| `]d` / `[d` | 下一个／上一个诊断 |
| `]D` / `[D` | 最后一个／第一个诊断 |
| `]e` / `[e` | 下一个／上一个错误 |
| `]w` / `[w` | 下一个／上一个警告 |
| `<Space>lD` | 搜索所有诊断 |
| `<Space>uv` | 开关行尾诊断文本 |
| `<Space>uV` | 开关多行诊断显示 |
| `<Space>ud` | 开关 Diagnostics |

## Git

当前配置会持续显示当前行的 Git blame。以下 hunk 操作只会在 Git 文件 Buffer 中出现。

| 按键 | 操作 |
| --- | --- |
| `]g` / `[g` | 下一个／上一个 Git hunk |
| `]G` / `[G` | 最后一个／第一个 Git hunk |
| `<Space>gp` | 行内预览当前 hunk |
| `<Space>gl` / `<Space>gL` | 查看简短／完整 blame |
| `<Space>gs` | 暂存或取消暂存当前 hunk |
| Visual 模式下 `<Space>gs` | 暂存选中行 |
| `<Space>gS` | 暂存整个 Buffer |
| `<Space>gr` | 恢复当前 hunk |
| `<Space>gR` | 恢复当前 Buffer 的全部修改 |
| `<Space>gd` | 查看当前文件 diff |
| `vig` | 选中当前 Git hunk；也可以使用 `yig`、`dig` |
| `<Space>gt` | 查看 Git status |
| `<Space>gb` | 查看或切换分支 |
| `<Space>gc` | 查看仓库提交历史 |
| `<Space>gC` | 查看当前文件提交历史 |
| `<Space>gT` | 查看 stash |
| `<Space>gg` / `<Space>tl` | 打开 Lazygit |
| `<Space>go` | 在远端仓库页面打开当前文件 |

Visual 模式选中若干行后按 `<Space>go`，可以在远端仓库页面打开对应的行范围，适合分享代码位置。

## 终端

| 按键 | 操作 |
| --- | --- |
| `<F7>` | 显示或隐藏终端 |
| `<C-'>` | 显示或隐藏终端，终端软件支持时可用 |
| `<Space>tf` | 浮动终端 |
| `<Space>th` | 水平终端 |
| `<Space>tv` | 垂直终端 |
| `<Space>tn` | Node REPL |
| `<Space>tp` | Python REPL |
| `<Space>tt` | 打开 `btm` |
| `<Space>tu` | 打开 `gdu` |
| `<Space>tl` | 打开 Lazygit |

## 会话

| 按键 | 操作 |
| --- | --- |
| `<Space>Sl` | 恢复上一次会话 |
| `<Space>Ss` | 保存当前会话 |
| `<Space>Sf` | 选择并加载会话 |
| `<Space>Sd` | 选择并删除会话 |
| `<Space>SS` | 以当前目录名保存 dirsession |
| `<Space>S.` | 加载当前目录的 dirsession |
| `<Space>SF` | 选择并加载 dirsession |
| `<Space>St` | 保存当前 Tab 的会话 |

## 调试

| 按键 | 操作 |
| --- | --- |
| `<F5>` / `<Space>dc` | 启动或继续调试 |
| `<F6>` / `<Space>dp` | 暂停 |
| `<F9>` / `<Space>db` | 设置或取消断点 |
| `<S-F9>` / `<Space>dC` | 条件断点 |
| `<F10>` / `<Space>do` | Step Over |
| `<F11>` / `<Space>di` | Step Into |
| `<S-F11>` / `<Space>dO` | Step Out |
| `<C-F5>` / `<Space>dr` | 重启调试 |
| `<S-F5>` / `<Space>dQ` | 终止调试 |
| `<Space>du` | 显示或隐藏调试 UI |
| `<Space>dh` | 查看调试值 |
| `<Space>dE` | 输入表达式并求值 |
| `<Space>dR` | 显示或隐藏 REPL |
| `<Space>ds` | 运行到光标位置 |
| `<Space>dB` | 清除全部断点 |

## UI 与功能开关

| 按键 | 操作 |
| --- | --- |
| `<Space>uZ` | Zen 模式 |
| `<Space>uw` | 自动换行 |
| `<Space>un` | 行号显示方式 |
| `<Space>ui` | 缩进设置 |
| `<Space>u\|` | 缩进参考线 |
| `<Space>us` | 拼写检查 |
| `<Space>uS` | Conceal |
| `<Space>up` | Paste 模式 |
| `<Space>ub` | 明暗背景 |
| `<Space>uc` / `<Space>uC` | 当前 Buffer／全局自动补全 |
| `<Space>ur` / `<Space>uR` | 当前 Buffer／全局引用高亮 |
| `<Space>uz` | 颜色值高亮 |
| `<Space>uy` | 当前 Buffer 语法高亮 |
| `<Space>ug` | Sign column |
| `<Space>u>` | Fold column |
| `<Space>ul` | Statusline |
| `<Space>ut` | Tabline |
| `<Space>uD` | 清除通知 |

## Markdown

| 按键 | 操作 |
| --- | --- |
| `<Space>mp` | 全屏启动 mdterm（`q` 退出并返回） |
| mdterm 中 `<C-f>` / `<C-b>` | 向下／向上翻页 |

## 维护配置

| 按键 | 操作 |
| --- | --- |
| `<Space>fa` | 查找 AstroNvim 配置文件 |
| `<Space>ps` | 打开插件状态界面 |
| `<Space>pS` | 同步插件 |
| `<Space>pu` | 检查插件更新 |
| `<Space>pU` | 更新插件 |
| `<Space>pm` | 打开 Mason 安装器 |
| `<Space>pa` | 更新 Lazy 和 Mason 包 |

## 容易混淆的按键

- `<Space>R` 重命名的是当前文件；`grn` 或 `<Space>lr` 重命名的是代码符号。
- Neo-tree 中 `Y` 复制路径文本；`y` 复制文件节点。
- `<Space>gd` 查看 Git diff；`gd` 跳转到代码定义。
- `<Space>gl` 查看 Git blame；`gl` 查看诊断信息。
- `<Space>go` 打开远端 Git 页面；`gx` 用本机默认程序打开 URL 或文件。
- `<Space>ff` 遵循常规忽略规则；`<Space>fF` 会包含隐藏和被忽略文件。
