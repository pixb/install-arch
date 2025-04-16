return {
  {
    "weirongxu/plantuml-previewer.vim",
    dependencies = {
      "tyru/open-browser.vim",
      "aklt/plantuml-syntax",
    },
    keys = {
      { "<Leader>cu", "<cmd>PlantumlOpen<cr>", desc = "Plantuml Open Run" },
    },
  },
}
