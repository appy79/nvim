return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-ts-autotag").setup({
      opts = {
        -- Enable auto-closing tags globally
        enable_close = true,
        -- Enable auto-renaming tags globally
        enable_rename = true,
        -- Enable closing tags on '/' press
        enable_close_on_slash = true,
      },
    })
  end,
}
