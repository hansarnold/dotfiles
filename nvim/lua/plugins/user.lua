---@type LazySpec
return {
  -- Neovim 0.12 needs Aerial v4's updated Treesitter API usage.
  {
    "stevearc/aerial.nvim",
    version = vim.fn.has "nvim-0.12" == 1 and "^4" or "^3",
  },
  -- AstroNvim keeps the legacy option for Neovim 0.11 compatibility, but it
  -- is deprecated on 0.12 and the configured on_jump callback replaces it.
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      if vim.fn.has "nvim-0.12" == 1 then opts.diagnostics.jump.float = nil end
    end,
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
}
