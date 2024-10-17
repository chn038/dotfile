return {
    {
        'mbbill/undotree',
        config = function()
            vim.undofile = true
            vim.undodir = '~/.nvim/undodir'
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end,
    },
}
