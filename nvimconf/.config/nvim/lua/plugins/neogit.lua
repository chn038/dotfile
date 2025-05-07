return {
    {
        'echasnovski/mini.diff',
        version = false,
        config = function()
            require("mini.diff").setup()
        end
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",         -- required
        },
        config = true
    }
}
