-- Zettelkasten tool
-- https://github.com/zk-org/zk
_G.toggle_checkboxes_at_cursor = function()
  local line = vim.api.nvim_get_current_line()
  local new_line
  if line:match("%[%s%]") then
    new_line, _ = line:gsub("%[%s%]", "[x]")
  elseif line:match("%[x%]") then
    new_line, _ = line:gsub("%[x%]", "[ ]")
  end
  if new_line then
    vim.api.nvim_set_current_line(new_line)
  end
end

return {
  "zk-org/zk-nvim",
  name = "zk",
  opts = {
    picker = "snacks_picker", -- changed from "select" since you're using Snacks
    lsp = {
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
        on_attach = function(client, bufnr)
          local function zk_cr_expr()
            local line = vim.api.nvim_get_current_line()
            if line:match("%[%s%]") or line:match("%[x%]") then
              return "<cmd>lua _G.toggle_checkboxes_at_cursor()<CR>"
            end
            local cfile = vim.fn.expand("<cfile>")
            if cfile:match("^https?://") then
              return string.format("<cmd>silent !xdg-open %s<CR>", vim.fn.shellescape(cfile))
            end
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
          vim.keymap.set("n", "<CR>", zk_cr_expr, {
            buffer = bufnr,
            expr = true,
            desc = "zk LSP: Follow WikiLink or insert newline",
            silent = true,
          })
        end,
      },
      auto_attach = {
        enabled = true,
      },
    },
    tags = {
      multi_select_strategy = "AND",
    },
  },
  init = function()
    local commands = require("zk.commands")
    local zk = require("zk")
    local zk_api = require("zk.api")
    local zk_util = require("zk.util")

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

    vim.keymap.set("n", "<leader>nF", function()
      local notebook_path = zk_util.notebook_root(vim.fn.expand("%:p")) or vim.env.ZK_NOTEBOOK_DIR
      zk_api.list(notebook_path, {
        select = { "title", "path", "absPath", "tags" },
        sort = { "modified" },
      }, function(err, notes)
        if err then
          vim.notify("zk list error: " .. tostring(err), vim.log.levels.ERROR)
          return
        end
        local items = vim.tbl_map(function(note)
          local tag_str = ""
          if note.tags and #note.tags > 0 then
            tag_str = "  [" .. table.concat(note.tags, ", ") .. "]"
          end
          return {
            text = (note.title or note.path) .. tag_str,
            file = note.absPath,
            note = note,
          }
        end, notes)
        Snacks.picker.pick({
          title = "Zk Notes (title + tags)",
          items = items,
          format = function(item)
            local title = item.note.title or item.note.path
            local tag_str = ""
            if item.note.tags and #item.note.tags > 0 then
              tag_str = "  [" .. table.concat(item.note.tags, ", ") .. "]"
            end
            return {
              { title, "SnacksPickerLabel" },
              { tag_str, "Comment" },
            }
          end,
          confirm = function(picker, item)
            picker:close()
            if item then
              vim.cmd("edit " .. vim.fn.fnameescape(item.file))
            end
          end,
        })
      end)
    end, { desc = "Zk: find notes by title or tag" })
  end,
}
