-- general settings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.colorcolumn = "80"
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.laststatus = 3 -- for each window has its own status line

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- package installation
vim.pack.add({
    { src = "https://github.com/rose-pine/neovim",              name = "rose-pine" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/saghen/blink.cmp",              version = vim.version.range('1.*') },
    { src = "https://github.com/arborist-ts/arborist.nvim" },
    { src = "https://github.com/cbochs/grapple.nvim" },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
})
vim.cmd('packadd nvim.undotree')

-- package setups
require('rose-pine').setup()
vim.cmd('colorscheme rose-pine')
require('fzf-lua').setup({
    files = {
        hidden = true,
        follow = false,
        no_ignore = true,
        absolute_path = true
    },
    grep = {
        rg_glob = true,
        glob_flag = '--iglob'
    }
})
require('blink.cmp').setup({
    keymap = { preset = 'super-tab' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = {
        documentation = { auto_show = false },
        accept = { auto_brackets = { enabled = false } }
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = {
        implementation = "prefer_rust"
    },
})
require('arborist').setup({
    prefer_wasm = false,
    ensure_installed = { "c", "cpp", "cuda", "python", "java", "lua", "markdown" },
})
require 'lualine'.setup()
require("mason").setup()
require("mason-lspconfig").setup()
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end
})

local ClearPack = function()
    local orphanPacks = vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x) return x.spec.name end)
        :totable()
    local infoString = "The following packages are cleaned:\n"
    for _, value in pairs(orphanPacks) do
        infoString = infoString .. value .. "\n"
    end
    vim.pack.del(orphanPacks)
    print(infoString)
end

-- keymaps

-- leader key fall back
vim.keymap.set({ 'n', 'v' }, "<leader><leader>", " ", { desc = "just insert the space" })

-- lsp diagnose
vim.keymap.set('n', '<leader>h', vim.diagnostic.open_float, { desc = "open diagnostic info" })

-- vim.pack specific
vim.keymap.set('n', '<leader>pu', vim.pack.update, { desc = 'Update plugins' })
vim.keymap.set('n', '<leader>pp', function() vim.pack.update(nil, { offline = true }) end, { desc = 'Explore plugins' })
vim.keymap.set('n', '<leader>pc', ClearPack, { desc = 'Clear packages' })

-- grapple
vim.keymap.set("n", "<leader>a", require("grapple").toggle, { desc = "toggle grapple here" })
vim.keymap.set("n", "<leader>e", require("grapple").toggle_tags, { desc = "show the tag list" })
vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>", { desc = "goto first tag" })
vim.keymap.set("n", "<leader>2", "<cmd>Grapple select index=2<cr>", { desc = "goto second tag" })
vim.keymap.set("n", "<leader>3", "<cmd>Grapple select index=3<cr>", { desc = "goto third tag" })
vim.keymap.set("n", "<leader>4", "<cmd>Grapple select index=4<cr>", { desc = "goto forth tag" })

-- deal with file
vim.keymap.set('n', '<leader>f', ':FzfLua files<cr>', { desc = 'Open file finder' })
vim.keymap.set('n', '<leader>u', ':Undotree<cr>', { desc = 'Open undotree', silent = true })
vim.keymap.set('n', '<leader>/', ':grep ', { desc = 'Use grep to search string' })
vim.keymap.set('n', '<leader>?', ':FzfLua grep<cr>', { desc = 'Use fzf lua grep for fuzzy finder' })
