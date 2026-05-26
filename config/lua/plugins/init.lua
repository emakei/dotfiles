return {
  -- Dependencies
  "nvim-lua/plenary.nvim",
  "neovim/nvim-lspconfig",
  "stevearc/dressing.nvim",

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
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
  },

  -- Debugging
  'mfussenegger/nvim-dap',
  { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },

  -- Flutter
  {
    'nvim-flutter/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
      'mfussenegger/nvim-dap',
    },
    config = function()
      require("flutter-tools").setup({
        lsp = {
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
          },
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
        },
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          highlight = "Comment",
          prefix = "// ",
          enabled = true,
        },
      })
    end
  },

  -- Tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local inputs = require("neo-tree.ui.inputs")

      local function trash(state)
        local node = state.tree:get_node()
        if node.type == "message" then return end
        local _, name = require("neo-tree.utils").split_path(node.path)
        inputs.confirm("Are you sure you want to trash '" .. name .. "'?", function(confirmed)
          if not confirmed then return end
          vim.api.nvim_command("silent !trash " .. vim.fn.shellescape(node.path))
          require("neo-tree.sources.manager").refresh(state)
        end)
      end

      require("neo-tree").setup({
        window = {
          mappings = {
            ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true, title = 'Neo-tree Preview' } },
            ["T"] = trash,
          }
        },
        enable_git_status = true,
      })
    end
  },

  -- UI
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  }
}
