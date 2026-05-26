return {
  {
    "LintaoAmons/bookmarks.nvim",
    dependencies = { 
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua" 
    },
    config = function()
      require("bookmarks").setup({
        -- Add any custom configuration here if needed
      })
      -- Add keybindings
      vim.keymap.set("n", "mm", "<cmd>BookmarksMark<cr>", { desc = "Toggle Bookmark" })
      vim.keymap.set("n", "ma", "<cmd>BookmarksAnnotate<cr>", { desc = "Annotate Bookmark" })
      vim.keymap.set("n", "mc", "<cmd>BookmarksClear<cr>", { desc = "Clear Bookmarks" })
      vim.keymap.set("n", "ml", "<cmd>BookmarksList<cr>", { desc = "List Bookmarks" })
    end
  },
  { 'mfussenegger/nvim-dap' },
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
}
