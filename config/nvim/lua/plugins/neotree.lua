return {
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
  }
}
