-- lua/gemini.lua

local M = {}

M.setup = function()
  local ok, toggleterm = pcall(require, "toggleterm.terminal")
  if not ok then
    vim.notify("toggleterm.nvim not found, Gemini command disabled", vim.log.levels.ERROR)
    return
  end

  local Terminal = toggleterm.Terminal
  local gemini = Terminal:new({
    cmd = "gemini",
    direction = "float",
    float_opts = {
      border = "curved",
    },
    close_on_exit = true,
  })

  vim.api.nvim_create_user_command('Gemini', function()
    gemini:toggle()
  end, { desc = 'Open Gemini in a floating window' })
end

return M

