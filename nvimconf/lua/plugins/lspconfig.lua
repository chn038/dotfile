local DEFAULT_SETTINGS = {
    -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
    -- This setting has no relation with the `automatic_installation` setting.
    ---@type string[]
    ensure_installed = {'lua_ls', 'clangd', 'nil_ls', 'rust_analyzer', 'marksman', 'pyright'},

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    ---@type boolean
    automatic_installation = false,

    -- See `:h mason-lspconfig.setup_handlers()`
    ---@type table<string, fun(server_name: string)>?
    handlers = nil,
}
return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
            'hrsh7th/nvim-cmp',
        },
        lazy = false,
        config = function ()
            -- require('mason').setup()
            -- require('mason-lspconfig').setup(DEFAULT_SETTINGS)
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
            local lspconfig = require("lspconfig")
            lspconfig['lua_ls'].setup({
                capabilities = lsp_capabilities
            })
            lspconfig['clangd'].setup({
                capabilities = lsp_capabilities
            })
            lspconfig['nil_ls'].setup({
                capabilities = lsp_capabilities
            })
            lspconfig['rust_analyzer'].setup({
                capabilities = lsp_capabilities
            })
            lspconfig['marksman'].setup({
                capabilities = lsp_capabilities
            })
            lspconfig['pyright'].setup({
                capabilities = lsp_capabilities
            })
            vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, {})
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float)
            vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
            vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
            vim.keymap.set({'n', 'v'}, '<leader>c', vim.lsp.buf.code_action, {})
            vim.keymap.set('n', '<leader>H', vim.lsp.buf.signature_help, {})
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
        end
    },
}
