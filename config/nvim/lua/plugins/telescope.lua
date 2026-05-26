return {
  'nvim-telescope/telescope.nvim',
  commit = 'a0bbec21143c7c5f850e527d6118d0966f363b4b',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup {
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        }
      }
    }
    telescope.load_extension('fzf')
  end
}
