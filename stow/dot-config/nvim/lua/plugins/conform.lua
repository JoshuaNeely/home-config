return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      ["markdown"] = { "prettier" },
    },
    formatters = {
      prettier = {
        prepend_args = { "--print-width", "80", "--prose-wrap", "always" },
      },
    },
  },
}
