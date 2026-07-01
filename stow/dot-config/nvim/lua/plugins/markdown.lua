return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      link = {
        wiki = {
          pattern = "(%[%[[^%]]+%]%])",
          -- Captures the clean text and isolates the hyphen + 4 alphanumeric ID characters to be hidden
          --pattern = "^([^%-]+)(%-[%w][%w][%w][%w])$",
          icon = "", -- Use '  ' or '  ' (a closed book) here
        },
        custom = {
          wiki_clean = {
            --pattern = "^([^%-]+)(%-[%w][%w][%w][%w])$",
            pattern = "%[-_][%w][%w][%w][%w]",
            icon = "", -- Use '  ' or '  ' (a closed book) here
          },
          -- pattern = "(%[%[[^%]]+%]%])",
          -- Captures the clean text and isolates the hyphen + 4 alphanumeric ID characters to be hidden
        },
      },
    },
  },
}
