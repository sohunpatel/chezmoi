return {
    {
        "ziberenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({})
        end
    },
    {
        "olimorris/codecompanion.nvim",
        version = "^19.0.0",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-treesitter/nvim-treesitter" },
            { "zbirenbaum/copilot.lua" }
        },
        event = "BufEnter",
        config = function()
            require("codecompanion").setup({
                adapters = {
                    copilot = function()
                        return require("codecompanion.adapters").extend("copilot", {
                            schema = {
                                model = {
                                    default = "claude-4.6-sonnet"
                                }
                            }
                        })
                    end,
                    acp = {
                        copilot_acp = function()
                            return require("codecompanion.adapters").extend("copilot_acp", {})
                        end
                    }
                },
                interactions = {
                    chat = {
                        adapter = "copilot_acp"
                    },
                    cli = {
                        agent = "copilot",
                        agents = {
                            copilot = {
                                cmd = "copilot",
                                args = {},
                                description = "copilot cli",
                                provider = "terminal"
                            }
                        }
                    }
                }
            })

            vim.keymap.set({ "n", "v" }, "<leader>ac", function()
                require("codecompanion").chat({ params = { adapter = "copilot_acp" } })
            end, { desc = "Open Copilot ACP chat" })
            vim.keymap.set({ "n", "v" }, "<leader>ap", function()
                local prompt = vim.fn.input("Copilot prompt: ")
                if prompt ~= "" then
                    require("codecompanion").chat({
                        params = { adapter = "copilot_acp" },
                        user_prompt = prompt
                    })
                end
            end, { desc = "Prompt Copilot ACP" })
        end
    }
}
