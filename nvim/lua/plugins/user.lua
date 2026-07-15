---@type LazySpec
return {
  -- Use <Space><Space> as a shorter alias for <Space>ff (find files)
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader><Leader>"] = { "<Leader>ff", remap = true, desc = "Find files" },
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
}
