---@type LazySpec
return {
  {
    url = "git@sh-code.mthreads.com:han.zhang01/musa.nvim.git",
    name = "musa.nvim",
    -- Load before filetype detection so *.mu overrides Vim's MuPAD mapping.
    lazy = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cuda" } },
  },
}
