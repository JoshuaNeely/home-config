local wk = require("which-key")

wk.add({
  { "<leader>n", group = "notes" },
})

local zkopts = { noremap = true, silent = false }

vim.keymap.del("n", "<leader>n") -- remove leader-n to deconflict with notes workflows

-- two options for old org-roam muscle memory
vim.keymap.set("n", "<leader>nrf", function()
  vim.cmd("ZkNotes")
end, { desc = "Search Notes" })
vim.keymap.set("n", "<leader>nf", function()
  vim.cmd("ZkNotes")
end, { desc = "Search Notes" })

vim.keymap.set("n", "<leader>nb", function()
  vim.cmd("ZkBuffers")
end, { desc = "Search Active Notes" })

vim.keymap.set("n", "<leader>nrr", function()
  vim.cmd("ZkBacklinks")
end, { desc = "Show Buffer BackLinks" })

vim.keymap.set("n", "<leader>nl", function()
  vim.cmd("ZkLinks")
end, { desc = "Show Buffer Links" })

vim.keymap.set("n", "<leader>ni", function()
  vim.cmd("ZkInsertLink")
end, { desc = "Insert Link" })

local function slugify(s)
  s = s:lower()
  s = s:gsub("%W", "_") -- non-word chars → underscores
  s = s:gsub("_+", "_") -- collapse consecutive underscores
  s = s:gsub("^_+", "") -- trim leading underscores
  s = s:gsub("_+$", "") -- trim trailing underscores
  return s
end

vim.keymap.set("n", "<leader>nn", function()
  vim.ui.input({ prompt = "New Note Name: " }, function(input)
    if not input or input == "" then
      return
    end
    vim.cmd(string.format('ZkNew { title = "%s", id = "%s" }', input, slugify(input)))
    -- first use: slugified ("my_new_note")
    -- second use: keep original if you pass it separately
  end)
end, { desc = "New Note" })

vim.keymap.set("n", "<leader>nj", function()
  vim.cmd("ZkDaily")
end, { desc = "Create/Open Daily Journal Note" })

-- Search for the notes matching a given query.
vim.api.nvim_set_keymap(
  "n",
  "<leader>nq",
  "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>",
  zkopts
)

-- Preview a linked note.
vim.keymap.set("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", zkopts)
