return {
    {
        'nvim-telescope/telescope.nvim',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        keys = {
            { "<leader>f", ":Telescope find_files<CR>", {} },
            { "gs" , ":Telescope grep_string<CR>", {} },
            { "gb" , ":Telescope buffers<CR>", {} },
            { "gh" , ":Telescope help_tags<CR>", {} },
            { "gk" , ":Telescope keymaps<CR>", {} },
        },
        config = function()
            local trouble = require("trouble.sources.telescope")
            local telescope = require("telescope")
            telescope.setup {
                defaults = {
                    mappings = {
                        i = { ["<c-t>"] = trouble.open },
                        n = { ["<c-t>"] = trouble.open },
                    },
                },
            }
        end
    },
}
