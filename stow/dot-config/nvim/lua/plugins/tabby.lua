return {
  "nanozuki/tabby.nvim",
  lazy = false,

  config = function()
    vim.o.showtabline = 2

    -- local theme = {
    --   fill = "TabLineFill",
    --   current_tab = "TabLine",
    --   tab = "NonText",
    --   line_sep = "Cursor",
    -- }
    local theme = {
      -- this is carbonfox theme
      fill = "TabLineFill",
      head = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
      current_tab = { fg = "#1c1e26", bg = "#75beff", style = "italic" },
      tab = { fg = "#c5cdd9", bg = "#1c1e26", style = "italic" },
      win = { fg = "#1c1e26", bg = "#75beff", style = "italic" },
      tail = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
      line_sep = { fg = "#75beff", bg = "#1c1e26", style = "italic" },
    }

    require("tabby.tabline").set(function(line)
      return {
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab

          -- this plugin uses the background color of the highlight groups as the foreground of the symbol for the separators
          local left_sep

          if tab.is_current() then
            left_sep = line.sep("▎", theme.line_sep, theme.current_tab)
          else
            left_sep = line.sep("▎", theme.fill, theme.fill)
          end

          return {
            left_sep,
            tab.number(),
            tab.name(),
            line.sep(" ", hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        hl = theme.fill,
      }
    end)
  end,
}
