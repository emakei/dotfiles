return {
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    opts = {
      -- Настройки для красивого отображения (view mode)
      view = {
        display_mode = "border" -- или "none"
      }
    },
    keys = {
      { "<leader>cv", "<cmd>CsvViewEnable<cr>", desc = "Enable CSV View" },
      { "<leader>cd", "<cmd>CsvViewDisable<cr>", desc = "Disable CSV View" },
    }
  },
}
