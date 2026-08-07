local function open_mdterm()
  local source_buf = vim.api.nvim_get_current_buf()
  local source_tab = vim.api.nvim_get_current_tabpage()
  local source_win = vim.api.nvim_get_current_win()

  if vim.bo[source_buf].filetype ~= "markdown" then
    vim.notify("mdterm preview is only available for Markdown buffers", vim.log.levels.WARN)
    return
  end

  local path = vim.api.nvim_buf_get_name(source_buf)
  if path == "" then
    vim.notify("Save the Markdown file before opening mdterm", vim.log.levels.WARN)
    return
  end

  local executable = vim.fn.exepath "mdterm"
  if executable == "" then
    vim.notify("mdterm is not installed or not available in PATH", vim.log.levels.ERROR)
    return
  end

  local saved, err = pcall(vim.cmd.update)
  if not saved then
    vim.notify("Could not save the Markdown file: " .. err, vim.log.levels.ERROR)
    return
  end

  vim.cmd.tabnew()
  local preview_win = vim.api.nvim_get_current_win()
  local preview_buf = vim.api.nvim_get_current_buf()
  vim.bo[preview_buf].buflisted = false
  vim.bo[preview_buf].bufhidden = "wipe"

  local function close_preview()
    if vim.api.nvim_win_is_valid(preview_win) then
      vim.api.nvim_win_close(preview_win, true)
    elseif vim.api.nvim_buf_is_valid(preview_buf) then
      vim.api.nvim_buf_delete(preview_buf, { force = true })
    end

    if vim.api.nvim_tabpage_is_valid(source_tab) then
      vim.api.nvim_set_current_tabpage(source_tab)
      if vim.api.nvim_win_is_valid(source_win) then vim.api.nvim_set_current_win(source_win) end
    end
  end

  local job_id = vim.fn.jobstart({ executable, path }, {
    cwd = vim.fs.dirname(path),
    term = true,
    on_exit = function()
      vim.schedule(function()
        close_preview()
      end)
    end,
  })

  if job_id <= 0 then
    close_preview()
    vim.notify("Could not start mdterm", vim.log.levels.ERROR)
    return
  end

  local function send_mdterm(keys)
    vim.api.nvim_chan_send(job_id, keys)
    if vim.api.nvim_get_current_buf() == preview_buf then vim.cmd.startinsert() end
  end

  for _, mode in ipairs { "n", "t" } do
    vim.keymap.set(mode, "<ScrollWheelUp>", function() send_mdterm(("\27[A"):rep(3)) end, {
      buffer = preview_buf,
      desc = "Scroll mdterm up",
    })
    vim.keymap.set(mode, "<ScrollWheelDown>", function() send_mdterm(("\27[B"):rep(3)) end, {
      buffer = preview_buf,
      desc = "Scroll mdterm down",
    })
  end

  -- mdterm 2.0.0 treats Ctrl-f as plain `f` and opens the link picker.
  -- Translate the keys before they reach mdterm so it receives PageDown/PageUp.
  vim.keymap.set("t", "<C-f>", "<PageDown>", { buffer = preview_buf, desc = "Page down in mdterm" })
  vim.keymap.set("t", "<C-b>", "<PageUp>", { buffer = preview_buf, desc = "Page up in mdterm" })
  vim.keymap.set("n", "<C-f>", function() send_mdterm "\27[6~" end, {
    buffer = preview_buf,
    desc = "Page down in mdterm",
  })
  vim.keymap.set("n", "<C-b>", function() send_mdterm "\27[5~" end, {
    buffer = preview_buf,
    desc = "Page up in mdterm",
  })

  vim.bo[preview_buf].filetype = "mdterm"
  vim.wo[preview_win].number = false
  vim.wo[preview_win].relativenumber = false
  vim.wo[preview_win].signcolumn = "no"
  vim.cmd.startinsert()
end

---@type LazySpec
return {
  -- Use <Space><Space> as a shorter alias for <Space>ff (find files)
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader><Leader>"] = { "<Leader>ff", remap = true, desc = "Find files" },
          ["<Leader>mp"] = { open_mdterm, desc = "Open Markdown full-screen in mdterm" },
        },
      },
    },
  },
  -- Override gitsigns plugin options
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  -- Fix conflict between nvim-highlight-colors and crates.nvim LSP
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      exclude_filetypes = { "toml" },
    },
  },
  -- Open PDFs as plain binary buffers instead of previewing them with
  -- snacks.image: PDF conversion requires ghostscript, and without it every
  -- PDF opened with a "Conversion failed" error and a modified buffer.
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.image = opts.image or {}
      opts.image.formats = {
        "png",
        "jpg",
        "jpeg",
        "gif",
        "bmp",
        "webp",
        "tiff",
        "heic",
        "avif",
        "mp4",
        "mov",
        "avi",
        "mkv",
        "webm",
      }
    end,
  },
}
