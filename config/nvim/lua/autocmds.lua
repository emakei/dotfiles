local utils = require("utils")

-- Trigger checktime when files changes on disk
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.getcmdwintype() == "" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification when file is reloaded
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.INFO)
  end,
})

-- Command to compare buffer with file on disk
vim.api.nvim_create_user_command("DiffOrig", function()
  vim.cmd("vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis")
end, { desc = "Compare current buffer with file on disk" })

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end
})

-- OS Theme Sync
vim.api.nvim_create_autocmd({ "FocusGained", "VimResume" }, {
    group = vim.api.nvim_create_augroup("OSThemeSync", { clear = true }),
    callback = function()
        utils.sync_theme()
    end,
})

-- Terminal keymaps
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    utils.set_terminal_keymaps()
    vim.cmd("startinsert")
  end,
})

