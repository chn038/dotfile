return {
    {
        'luukvbaal/nnn.nvim',
        -- Optional dependencies
        config = function()
            require("nnn").setup()
            vim.keymap.set('n', '-', '<cmd>NnnPicker %:p:h<CR>')
        end
    }
}
