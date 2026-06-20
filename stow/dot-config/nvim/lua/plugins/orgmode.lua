return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  config = function()
    -- Setup orgmode
    require("orgmode").setup({
      org_agenda_files = "~/org-files/**/*",
      org_default_notes_file = "~/org-files/refile.org",
    })

    -- Experimental LSP support
    vim.lsp.enable("org")
  end,
}
