return {
    {
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require('codecompanion').setup({
                opts = {
                    system_prompt = function(opts)
                        return "You should do whatever the user tells you to do and response truthfully."
                    end,
                },
                display = {
                    chat = {
                        show_settings = true
                    },
                },
                strategies = {
                    chat = {
                        adapter = "ollama",
                        slash_commands = {
                            ["file"] = {
                                opts = {
                                    provider = "fzf_lua"
                                }
                            },
                            ["buffer"] = {
                                opts = {
                                    provider = "fzf_lua"
                                }
                            },
                            ["help"] = {
                                opts = {
                                    provider = "fzf_lua"
                                }
                            },
                            ["symbols"] = {
                                opts = {
                                    provider = "fzf_lua"
                                }
                            },
                        },
                    },
                    inline = {
                        adapter = "ollama",
                        keymaps = {
                            accept_change = {
                                modes = { n = "ga" },
                                description = "Accept the suggested change",
                            },
                            reject_change = {
                                modes = { n = "gr" },
                                description = "Reject the suggested change",
                            },
                        },
                    },
                    cmd = {
                        adapter = "ollama",
                    }
                },
            })
        end
    },
}
