return {
  {
    enabled = false,
    "akinsho/bufferline.nvim",

    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffer",
        always_show_bufferline = true,
        themable = true,
        --numbers = "buffer_id",
      },
    },
  },
}
