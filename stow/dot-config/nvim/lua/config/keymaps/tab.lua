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
