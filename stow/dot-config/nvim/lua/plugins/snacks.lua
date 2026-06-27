return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        files = { hidden = true },
        explorer = { hidden = true },
        smart = { hidden = true },
      },

      matcher = {
        fuzzy = true, -- Use fuzzy matching
        smartcase = true, -- Case-sensitive only if uppercase characters are typed
        ignorecase = true,
        filename_bonus = true, -- Prioritize the filename matching
      },
      sort = {
        -- Sort criteria: score, shortest text length, then index
        fields = { "score:desc", "#text", "idx" },
      },
    },
  },
}
