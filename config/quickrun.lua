return {
  {
    "thinca/vim-quickrun",
    cmd = "QuickRun",
    dependencies = {
      "tyru/open-browser.vim",
    },
    init = function()
      vim.g.quickrun_config = { ["_"] = { ["outputter"] = "message" } }
      vim.g.quickrun_config.html = { ["outputter"] = "google-chrome-stable" }
      vim.g.quickrun_config.markdown = {
        ["type"] = "markdown/pandoc",
        -- ["cmdopt"] = "-s",
        ["outputter"] = "browser",
      }
      vim.g.quickrun_no_default_key_mappings = 1
    end,
    keys = {
      { "<Leader>r", "<cmd>QuickRun<cr>", desc = "Quick Run" },
    },
  },
}
