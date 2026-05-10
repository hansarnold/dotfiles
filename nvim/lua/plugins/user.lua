---@type LazySpec
return {
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