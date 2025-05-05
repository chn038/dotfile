return {
    {
        "williamboman/mason.nvim",lazy = false,
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim", lazy = false,
        config = function()
            require("mason-lspconfig").setup()
            local capabilities = require('blink.cmp').get_lsp_capabilities()
            require("mason-lspconfig").setup_handlers {
                -- The first entry (without a key) will be the default handler
                -- and will be called for each installed server that doesn't have
                -- a dedicated handler.
                function (server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                -- Next, you can provide a dedicated handler for specific servers.
                -- For example, a handler override for the `rust_analyzer`:
                ["rust_analyzer"] = function ()
                    require("rust-tools").setup {
                        capabilities = capabilities
                    }
                end
            }
        end
    },
    {
        "neovim/nvim-lspconfig", lazy = false,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup()
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio"
        },
        config = function()
            require("dapui").setup()
        end
    },
    {
        "rshkarin/mason-nvim-lint",
        dependencies = {
            "mfussenegger/nvim-lint",
        },
        config = function()
            local DEFAULT_SETTINGS = {
                -- A list of linters to automatically install if they're not already installed. Example: { "eslint_d", "revive" }
                -- This setting has no relation with the `automatic_installation` setting.
                -- Names of linters should be taken from the mason's registry.
                ---@type string[]
                ensure_installed = {},

                -- Whether linters that are set up (via nvim-lint) should be automatically installed if they're not already installed.
                -- It tries to find the specified linters in the mason's registry to proceed with installation.
                -- This setting has no relation with the `ensure_installed` setting.
                ---@type boolean
                automatic_installation = false,

                -- Disables warning notifications about misconfigurations such as invalid linter entries and incorrect plugin load order.
                quiet_mode = false,
            }
            require('mason-nvim-lint').setup(DEFAULT_SETTINGS)
        end
    }
}
