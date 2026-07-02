-- Zettelkasten tool
-- https://github.com/zk-org/zk

_G.toggle_checkboxes_at_cursor = function()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match('%[%s%]') then
    new_line, _ = line:gsub('%[%s%]', '[x]')
  elseif line:match('%[x%]') then
    new_line, _ = line:gsub('%[x%]', '[ ]')
  end
  if new_line then
    vim.api.nvim_set_current_line(new_line)
  end
end

return {
  "zk-org/zk-nvim",
  name = "zk",
  opts = {
    -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
    -- or select" (`vim.ui.select`).
    picker = "select",

    lsp = {
      -- `config` is passed to `vim.lsp.start(config)`
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start()`

        on_attach = function(client, bufnr)
          -- Expression function: Returns what <CR> should actually execute
          --
          -- local function zk_cr_expr()
          --   local params = vim.lsp.util.make_position_params()
          --
          --   -- Synchronous, fast 150ms fallback window
          --   local response = vim.lsp.buf_request_sync(bufnr, "textDocument/definition", params, 150)
          --
          --   -- Check if LSP returned a valid definition result structure
          --   -- Neovim sync responses are structured as: { [client_id] = { result = { ... } } }
          --   if response then
          --     for _, lsp_res in pairs(response) do
          --       if lsp_res.result and not vim.tbl_isempty(lsp_res.result) then
          --         -- Tell Neovim to natively run the LSP definition jump
          --         return "<cmd>lua vim.lsp.buf.definition()<CR>"
          --       end
          --     end
          --   end
          --
          --   -- Fallback cleanly to a standard return key (escaping special termcodes)
          --   return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
          -- end
          --
          -- -- Set the keymap with expr = true to eliminate feedkeys interference
          -- vim.keymap.set("n", "<CR>", zk_cr_expr, {
          --   --buffer = bufnr,
          --   expr = true,
          --   desc = "zk LSP: Follow WikiLink or insert newline",
          --   silent = true,
          -- })
          -- Expression function: Returns what <CR> should actually execute
           local function zk_cr_expr()
             local line = vim.api.nvim_get_current_line()

             -- If cursor is on a checkbox line, toggle it
              if line:match('%[%s%]') or line:match('%[x%]') then
                return '<cmd>lua _G.toggle_checkboxes_at_cursor()<CR>'
              end

              -- If cursor is on a web URL, open it in the browser
              local cfile = vim.fn.expand('<cfile>')
              if cfile:match('^https?://') then
                return string.format('<cmd>silent !xdg-open %s<CR>', vim.fn.shellescape(cfile))
              end

              -- Fetch the active zk LSP client attached to this buffer
             local clients = vim.lsp.get_clients({ name = "zk", bufnr = 0 })
             if vim.tbl_isempty(clients) then
               return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
             end
             local zk_client = clients[1]
             local params = vim.lsp.util.make_position_params(0, zk_client.offset_encoding)

             local response = vim.lsp.buf_request_sync(bufnr, "textDocument/definition", params, 150)

             if response then
               for _, lsp_res in pairs(response) do
                 if lsp_res.result and not vim.tbl_isempty(lsp_res.result) then
                   return "<cmd>lua vim.lsp.buf.definition()<CR>"
                 end
               end
             end

             return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
           end

          -- Set the keymap with expr = true to eliminate feedkeys interference
          vim.keymap.set("n", "<CR>", zk_cr_expr, {
            buffer = bufnr,
            expr = true,
            desc = "zk LSP: Follow WikiLink or insert newline",
            silent = true,
          })
        end,
      },

      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
      },
    },

    tags = {
      -- Configure how multiple tags should be combined in a ZkTags search
      -- Can be "AND" or "OR"
      multi_select_strategy = "AND",
    },
  },
   init = function()
    local commands = require("zk.commands")
    local zk = require("zk")

    commands.add("ZkDaily", function(options)
      options = vim.tbl_extend("force", { dir = "journal/daily" }, options or {})
      zk.new(options)
    end)

    commands.add("ZkMention", function(options)
      options = vim.tbl_extend("force", {
        match = { "term" },
        sort = { "modified" },
        select = { "absPath", "title", "id", "tags", "frontmatter" },
      }, options or {})

      local api = require("zk.api")
      local ui = require("zk.ui")
      local path = vim.fn.expand("%:p")

      api.list(path, options, function(err, notes)
        if err then
          vim.notify("zk error: " .. tostring(err), vim.log.levels.ERROR)
          return
        end
        ui.pick_notes(notes, {
          title = "Zk Mention",
          multi_select = false,
          snacks_picker = {
            layout = { preset = "ivy" },
            preview = true,
          },
        }, function(note)
          vim.cmd("e " .. note.absPath)
        end)
      end)
    end)
  end,
}
