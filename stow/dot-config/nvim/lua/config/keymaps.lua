-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- ###########################33
-- vim.keymap.set(MODE)
-- MODE is one of "v" for visual, "n" for normal, "t" for terminal, "i" for insert, ....(more?)
-- We can select a single option or a number of them
-- vim.keymap.set("v")  vs  vim.keymap.set({"v", "t"})
-- We can select all modes with "" or {}
-- ###########################33

-- term normally eats your ESC trigger that you want to return to NORMAL mode.
-- You can manually send that command with C-/ C=n but I find little use for sending
-- ESC to the terminal, so I prefer escaping as the default. If I REALLY want ESC sent to the
-- terminal, I can use C-Esc
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
vim.keymap.set("t", "<C-Esc>", "<Esc>", { desc = "Send Escape to terminal" })

vim.keymap.set("t", "<C-h>", [[<C-\><C-N><C-w>h]], { desc = "Navigate nvim panes from terminal" })
vim.keymap.set("t", "<C-l>", [[C-\><C-N><C-w>l]], { desc = "Navigate nvim panes from terminal" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-N><C-w>j]], { desc = "Navigate nvim panes from terminal" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-N><C-w>k]], { desc = "Navigate nvim panes from terminal" })

vim.keymap.set({ "" }, "<M-x>", function()
  Snacks.picker.commands()
end, { desc = "a doom-emacs flavored method for opening the cmd palette" })

vim.keymap.set("n", "<leader>ff", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")

vim.keymap.set("n", "<leader>fx", function()
  local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

  if confirm == 1 then
    os.remove(vim.fn.expand("%"))
    vim.api.nvim_buf_delete(0, { force = true })
  end
end, { desc = "Delete current file" })

-- emulating some emacs buffer muscle memory
vim.keymap.set("n", "<leader>bs", function()
  vim.cmd("write")
end, { desc = "Save buffer" })

vim.keymap.set("n", "<leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "Find buffer" })

vim.keymap.set("n", "<leader>bi", function()
  vim.cmd("Tabby pick_window")
end, { desc = "Rename Tab" })

-- ########################### TAB ############################
-- Create a new tab with an interactive name prompt
vim.keymap.set("n", "<leader><tab>N", function()
  vim.ui.input({ prompt = "Enter new tab name: " }, function(input)
    if not input or input == "" then
      return
    end

    vim.cmd("tabnew")
    --vim.cmd("BufferLineTabRename " .. input)
    vim.cmd("Tabby rename_tab " .. input)
  end)
end, { desc = "Create and rename new tab" })

vim.keymap.set("n", "<leader><tab>n", function()
  vim.cmd("tabnew")
end, { desc = "Create new tab" })

vim.keymap.set("n", "<leader><tab>r", function()
  vim.ui.input({ prompt = "Enter new tab name: " }, function(input)
    if not input or input == "" then
      return
    end
    -- vim.cmd("BufferLineTabRename " .. input)
    vim.cmd("Tabby rename_tab " .. input)
  end)
end, { desc = "Rename Tab" })

vim.keymap.del("n", "<leader><tab><tab>")
vim.keymap.del("n", "<C-/>")

for i = 1, 9 do
  vim.keymap.set("n", "<M-" .. i .. ">", "<cmd>tabnext " .. i .. "<CR>", { desc = "Jump to tab " .. i })
end
-- ############################################################

vim.keymap.set("n", "<leader>fR", function()
  local current_file = vim.fn.expand("%:p")
  vim.ui.input({ prompt = "Move/Rename to: ", default = current_file, completion = "file" }, function(new_file)
    if new_file and new_file ~= "" and new_file ~= current_file then
      -- Rename/move the file on disk
      local success, err = pcall(vim.fn.rename, current_file, new_file)
      if success then
        -- Open the new file and wipe the old buffer
        vim.cmd("e " .. vim.fn.fnameescape(new_file))
        vim.cmd("bd " .. vim.fn.fnameescape(current_file))
        print("Successfully moved/renamed file to " .. new_file)
      else
        print("Filed to move file: " .. err)
      end
    end
  end)
end, { desc = "Rename or move current file" })
