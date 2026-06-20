return {
  "snacks.nvim",
  opts = {
    picker = {
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
