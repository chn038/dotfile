return {
    {
        'L3MON4D3/LuaSnip',
        version = "*",
        dependencies = {
            'rafamadriz/friendly-snippets',
            config = function()
                require('luasnip.loaders.from_vscode').lazy_load()
            end,
        },
    },
    {
        'saghen/blink.cmp',
        version = '*',
        -- !Important! Make sure you're using the latest release of LuaSnip
        -- `main` does not work at the moment
        opts = {
            keymap = { preset = "enter" },
            completion = {
                menu = {
                    auto_show = true;
                },
                list = {
                    cycle = {
                        from_top = true,
                        from_bottom = true
                    },
                },
            },
            snippets = { preset = 'luasnip' },
            -- ensure you have the `snippets` source (enabled by default)
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                per_filetype = {
                    codecompanion = { "codecompanion"}
                },
            },
        }
    }
}
