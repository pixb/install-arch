local filename = vim.fn.expand("%:t")
-- delete expand name,add concat oprator .
filename = string.gsub(filename, "%..*", "") .. "."
return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
  config = function()
    require("img-clip").setup({
      default = {
        dir_path = filename .. "assert",
        insert_mode_after_paste = false,
      },
      filetypes = {
        markdown = {
          url_encode_path = true, ---@type boolean
          template = "![$FILE_NAME_NO_EXT]($FILE_PATH)",
          downland_images = false, ---@type boolean
        },
      },
    })
  end,
}
