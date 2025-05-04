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
    }
}
