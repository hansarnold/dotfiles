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
