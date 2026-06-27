--lua/plugins/telescope-file-picker.lua
return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local fb_actions = require("telescope").extensions.file_browser.actions

    require("telescope").setup({
      extensions = {
        file_browser = {
          mappings = {
            ["i"] = {
              ["<Tab>"] = fb_actions.open_dir,
              ["<C-h>"] = fb_actions.goto_home_dir,
            },
            ["n"] = {
              f = false,
            },
          },
        },
      },
    })

    require("telescope").load_extension("file_browser")
  end,
}
