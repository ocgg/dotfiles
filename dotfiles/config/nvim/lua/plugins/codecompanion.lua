return {
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "HakonHarnes/img-clip.nvim",
    },
    "olimorris/codecompanion.nvim",
    opts = {
        -- strategies = {
        --     chat = {
        --         adapter = {
        --             name = "copilot",
        --             model = "claude-sonnet-4-20250514",
        --         },
        --         tools = {
        --             opts = {
        --                 default_tools = {
        --                     "my_tool",
        --                     "my_tool_group"
        --                 }
        --             },
        --         }
        --     },
        --     inline = {
        --         adapter = "copilot",
        --     },
        --     cmd = {
        --         adapter = "deepseek",
        --     }
        -- },
        adapters = {
            -- copilot = {},
            http = {
                openai = function()
                    local dotenv = dofile(vim.fn.stdpath("config") .. "/.env")
                    return require("codecompanion.adapters").extend("openai", {
                        env = {
                            api_key = dotenv.OPENAI_API_KEY
                        },
                    })
                end,
            }
        },
    },
    vim.keymap.set({ "n", "v" }, "<leader>ii", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true }),
    vim.keymap.set({ "n", "v" }, "<leader>ia", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true }),
}
