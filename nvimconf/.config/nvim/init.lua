-- Put this at the top of 'init.lua'
local path_package = vim.fn.stdpath('data') .. '/site'
local mini_path = path_package .. '/pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
    vim.cmd('echo "Installing `mini.nvim`" | redraw')
    local clone_cmd = {
        'git', 'clone', '--filter=blob:none',
        -- Uncomment next line to use 'stable' branch
        -- '--branch', 'stable',
        'https://github.com/nvim-mini/mini.nvim', mini_path
    }
    vim.fn.system(clone_cmd)
    vim.cmd('packadd mini.nvim | helptags ALL')
    vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup()

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- general settings
now(function()
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
end)

-- initial call
now(function()
    require('mini.statusline').setup()
    require('mini.tabline').setup()
    require('mini.notify').setup()
    require('mini.icons').setup()
end)

-- colorscheme
now(function()
    add({ source = "rose-pine/neovim", name = 'rose-pine' })
    require('rose-pine').setup()
    vim.cmd('colorscheme rose-pine')
end)

-- regarding to mini
later(function()
    require('mini.diff').setup()
    require('mini.git').setup()
    require('mini.pick').setup()
    require('mini.fuzzy').setup()
    require('mini.visits').setup()
    -- only use visits as manual labeling
    vim.g.minivisits_disable = true
end)

-- undotree
later(function()
    add({
        source = 'mbbill/undotree'
    })
end)

-- codediff
later(function()
    add({
        source = 'sindrets/diffview.nvim'
    })
end)

-- snippets and completion
later(function()
    local gen_loader = require('mini.snippets').gen_loader
    add({
        source = "rafamadriz/friendly-snippets"
    })
    require('mini.snippets').setup({
        snippets = {
            -- Load snippets based on current language by reading files from
            -- "snippets/" subdirectories from 'runtimepath' directories.
            gen_loader.from_lang(),
        },
    })
    MiniSnippets.start_lsp_server()
    require('mini.completion').setup()
end)

-- lsp config
later(function()
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
    vim.lsp.enable("clangd")
    vim.lsp.enable("zuban")
    vim.lsp.enable("ruff")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("texlab")
    vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function()
            vim.lsp.buf.format({ async = false })
        end,
    })
end)

-- nvim-treesitter
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd("TSUpdate") end }
    })
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
end)


-- keybindings
later(function()
    local mini_pick_hidden = function()
        MiniPick.builtin.cli({
            command = { 'fd', '--hidden', '--type', 'f', '--type', 'd', '-I', '-i' }
        })
    end
    -- leader key fall back
    vim.keymap.set({ 'n', 'v' }, "<leader><leader>", " ", { desc = "just insert the space" })

    -- lsp diagnose
    vim.keymap.set('n', '<leader>h', vim.diagnostic.open_float, { desc = "open diagnostic info" })

    -- mini.visit
    vim.keymap.set("n", "<leader>a", function() MiniVisits.add_label("core") end, { desc = "add label" })
    vim.keymap.set("n", "<leader>d", function() MiniVisits.remove_label("core") end, { desc = "delete label" })
    vim.keymap.set("n", "<leader>e", function() MiniVisits.select_path(nil, { filter = "core" }) end,
        { desc = "select label" })

    -- deal with file
    vim.keymap.set('n', '<leader>f', mini_pick_hidden, { desc = 'Open file finder' })
    vim.keymap.set('n', '<leader>u', ':UndotreeToggle<cr>', { desc = 'Open undotree', silent = true })
    vim.keymap.set('n', '<leader>/', ':grep ', { desc = 'Use grep to search string' })
    vim.keymap.set('n', '<leader>?', ':Pick grep<cr>', { desc = 'Use fzf style grep to search string' })

    -- deal with git
    vim.keymap.set('n', '<leader>g', ':Git ', { desc = "Open git" })
end)

-- mini.clue
later(function()
    local miniclue = require('mini.clue')
    require('mini.clue').setup({
        triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },

        clues = {
            -- Enhance this by adding descriptions for <Leader> mapping groups
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
        },
    })
end)
