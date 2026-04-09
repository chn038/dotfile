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

vim.pack.add({
    { src = "https://github.com/shaunsingh/nord.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/cbochs/grapple.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range('1.*')
    },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- hooks
vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == 'nvim-treesitter' and kind == 'update' then
            if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
            vim.cmd('TSUpdate')
        end
    end
})

vim.cmd('colorscheme nord')

vim.lsp.config("clangd", {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp' },
    root_markers = { '.git' },
})
vim.lsp.config("zuban", {
    cmd = { 'zuban', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', '.git' },
})
vim.lsp.config("ruff", {
    cmd = { 'ruff', 'server' },
    filetypes = { 'python' },
    root_markers = { 'pyproject.toml', '.git' },
})
vim.lsp.config("lua_ls", {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.git' }
})
vim.lsp.config("texlab", {
    cmd = { 'texlab' },
    filetypes = { 'tex', 'plaintex' },
    root_markers = { '.git' }
})
vim.lsp.config("jdtls", {
    cmd = { 'jdtls' },
    filetypes = { 'java' },
    root_markers = { '.git' }
})
vim.lsp.enable("clangd")
vim.lsp.enable("zuban")
vim.lsp.enable("ruff")
vim.lsp.enable("lua_ls")
vim.lsp.enable("texlab")
vim.lsp.enable("jdtls")
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format({ async = false })
    end,
})

-- setups
require 'nvim-treesitter'.setup {
    -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
    install_dir = vim.fn.stdpath('data') .. '/site'
}

require 'nvim-treesitter'.install({ 'python', 'c', 'cpp', 'cuda', 'lua', 'markdown' },
    { generate = true, summary = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'python', 'c', 'cpp', 'cuda', 'lua', 'markdown' },
    callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})

require 'fzf-lua'.setup {
    files = {
        hidden = true,
        no_ignore = true
    },
}

require 'blink.cmp'.setup {
    keymap = { preset = 'super-tab' },
    appearance = { nerd_font_variant = "mono" },
    completion = { documentation = { auto_show = true } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    opts_extend = { "sources.default" }
}

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'nord',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
            refresh_time = 16, -- ~60fps
            events = {
                'WinEnter',
                'BufEnter',
                'BufWritePost',
                'SessionLoadPost',
                'FileChangedShellPost',
                'VimResized',
                'Filetype',
                'CursorMoved',
                'CursorMovedI',
                'ModeChanged',
            },
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}

local CleanPackage = function()
    local unused_packages = vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x)
            return x.spec.name
        end)
        :totable()
    vim.pack.del(unused_packages)
    local pack_list = "Delete the following packages:\n"
    for _, pack in pairs(unused_packages) do
        pack_list = pack_list .. pack .. "\n"
    end
    print(pack_list)
end

local ShowPackageList = function()
    local pack_list = "Installed packages:\n"
    for _, pack in pairs(vim.pack.get()) do
        pack_list = pack_list .. pack.spec.name .. "\n"
    end
    print(pack_list)
end

-- keybindings
-- leader key fall back
vim.keymap.set({ 'n', 'v' }, "<leader><leader>", " ", { desc = "just insert the space" })

-- package update and package clean
vim.keymap.set('n', "<leader>pu", function() vim.pack.update() end, { desc = "update plugins" })
vim.keymap.set('n', "<leader>pc", CleanPackage, { desc = "clean up packages" })
vim.keymap.set('n', "<leader>pp", ShowPackageList, { desc = "show packages" })

-- grapple
vim.keymap.set("n", "<leader>a", require("grapple").toggle, { desc = "toggle grapple here" })
vim.keymap.set("n", "<leader>e", require("grapple").toggle_tags, { desc = "show the tag list" })
vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>", { desc = "goto first tag" })
vim.keymap.set("n", "<leader>2", "<cmd>Grapple select index=2<cr>", { desc = "goto second tag" })
vim.keymap.set("n", "<leader>3", "<cmd>Grapple select index=3<cr>", { desc = "goto third tag" })
vim.keymap.set("n", "<leader>4", "<cmd>Grapple select index=4<cr>", { desc = "goto forth tag" })

-- deal with lsp
vim.keymap.set('n', "<leader>h", vim.diagnostic.open_float, { desc = "open diagnostic message under cursor" })

-- deal with file
vim.keymap.set('n', '<leader>f', ':FzfLua files<cr>', { desc = 'Open file picker' })
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<cr>', { desc = 'Open undotree', silent = true })
vim.keymap.set('n', '<leader>/', ':grep ', { desc = 'Use grep to search string' })
