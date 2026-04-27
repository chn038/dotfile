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
vim.opt.foldminlines = 3
vim.opt.foldnestmax = 2
vim.opt.foldcolumn = 'auto'

vim.opt.foldtext = vim.fn.getline(vim.v.foldstart)

-- package installaion
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
    { src = "https://codeberg.org/mfussenegger/nvim-dap" },
    { src = "https://github.com/igorlfs/nvim-dap-view",         version = vim.version.range('1.*') },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" }
})
vim.cmd('packadd nvim.undotree')

-- package setups
-- basic settings
require('rose-pine').setup()
vim.cmd('colorscheme rose-pine')
require 'lualine'.setup()
require('fzf-lua').setup({
    files = {
        hidden = true,
        follow = false,
        no_ignore = true,
        absolute_path = false
    },
    grep = {
        rg_glob = true,
        glob_flag = '--iglob'
    }
})

-- auto completion
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

-- treesitter
require('arborist').setup({
    prefer_wasm = false,
    ensure_installed = { "c", "cpp", "cuda", "python", "java", "lua", "markdown" },
})

-- lsp settings
require("mason").setup()
require("mason-lspconfig").setup()
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end
})
---- java specific package
vim.pack.add({ "https://codeberg.org/mfussenegger/nvim-jdtls" })
local mason_root = require('mason.settings').current.install_root_dir
local bundles = {
    vim.fn.glob(mason_root ..
        '/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar') }
vim.list_extend(bundles,
    vim.fn.glob(mason_root .. '/packages/java-test/extension/server/*.jar', false, true))
require('jdtls').start_or_attach({
    cmd = { 'jdtls' },
    settings = {
        java = {
            configuration = {
                runtimes = {
                    name = "JavaSE-17",
                    path = "/usr/lib/jvm/java-17-openjdk/",
                    default = true,
                }
            }
        },
    },
    init_options = {
        bundles = bundles
    },
    on_attach = function(client, bufnr)
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        require('jdtls.dap').setup_dap_main_class_configs()
    end
})
----

-- debugger setting
require("mason-nvim-dap").setup({
    handlers = {}
})
--
-- helper function for increasing readability of vim.pack
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
vim.keymap.set('n', '<leader>r', ':FzfLua resume<cr>', { desc = 'Reuse last fzf picker' })

-- debugging
vim.keymap.set("n", "<leader>h", vim.diagnostic.open_float, { desc = "open debug message" })
vim.keymap.set('n', '<leader>db', require('dap').toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dd', function()
    require('dap').continue()
    require('dap-view').open()
end, { desc = 'Start debugging' })
vim.keymap.set('n', '<leader>dc', require('dap').continue, { desc = 'Resume debugging' })
vim.keymap.set('n', '<leader>dt', function()
    require('dap-view').close()
    require('dap').terminate()
end, { desc = 'Stop debugging' })
vim.keymap.set('n', '<leader>dj', require('dap').step_over, { desc = 'Step over the line' })
vim.keymap.set('n', '<leader>dk', require('dap').restart_frame, { desc = 'Restart frame' })
vim.keymap.set('n', '<leader>dh', require('dap').step_out, { desc = 'Step out the line' })
vim.keymap.set('n', '<leader>dl', require('dap').step_into, { desc = 'Step into the line' })
