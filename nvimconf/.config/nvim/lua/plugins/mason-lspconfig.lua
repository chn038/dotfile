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
        end
    },
    {
        "neovim/nvim-lspconfig", lazy = false,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
            require("mason-nvim-dap").setup({
                ensure_installed = { 'codelldb' },
                handlers = {}
            })
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
