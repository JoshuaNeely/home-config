-- Used to reload config files... any good for refreshing lints, etc?
local function reloadCurrentFile()
  print("Reloading File")
  vim.api.nvim_command("source %")
end

-- 2. Create the command that shows up in the command pane
vim.api.nvim_create_user_command("ReloadFile", reloadCurrentFile, {})

vim.opt.relativenumber = false

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Get the full path of the current buffer
    local current_file = vim.api.nvim_buf_get_name(0)

    -- Skip empty buffers or special buffers (like terminal, NvimTree, etc.)
    if current_file == "" or vim.bo.buftype ~= "" then
      return
    end

    -- Find the directory containing the current file
    local current_dir = vim.fs.dirname(current_file)

    -- Find the topmost .git directory starting from the current file's directory
    local git_root = vim.fs.find(".git", {
      path = current_dir,
      upward = true,
    })[1]

    if vim.bo.buftype ~= "terminal" then
      vim.cmd("silent! lcd %:p:h")
    else
      if git_root then
        -- Set cwd to the parent of the .git directory
        vim.cmd("cd " .. vim.fs.dirname(git_root))
        print(string.format("Setting CWS to %s", git_root))
      else
        -- Fallback: set cwd to the file's directory if not in a git repo
        vim.cmd("cd " .. current_dir)
        print(string.format("Setting CWS to %s", current_dir))
      end
    end
  end,
})

-- Replace the default 'switch to other buffer' with the buffer picker
vim.keymap.set("n", "<leader>bb", function()
  Snacks.picker.buffers()
end, { desc = "Find Buffers" })

-- Reload changes to disk when reloading file
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = function()
    vim.cmd("checktime")
  end,
})

-- session saving
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,globals"
