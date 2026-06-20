return {
  "olimorris/codecompanion.nvim",
  version = "^19.0.0",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    interactions = {
      chat = {
        adapter = "llama.cpp",
        model = "qwen3.6-mtp",
      },
      inline = {
        adapter = "llama.cpp",
        model = "qwen3.6-mtp",
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG",
    },
    adapters = {
      http = {
        ["llama.cpp"] = function()
          return require("codecompanion.adapters").extend("openai_compatible", {
            schema = {
              model = {
                default = "qwen3.6-mtp",
              },
            },
            name = "llama.cpp",
            env = {
              url = "http://10.0.0.10:8888",
              api_key = "NONE",
              chat_url = "/v1/chat/completions",
            },
            opts = {
              model = "qwen3.6-mtp",
            },
          })
        end,
      },
    },
  },
}
