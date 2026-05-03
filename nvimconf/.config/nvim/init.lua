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

local add, now, later = require('mini.deps').add, require('mini.deps').now, require('mini.deps').later

-- general settings
now(function()
    -- general settings
    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    vim.opt.colorcolumn = "80"
    vim.opt.expandtab = true
    vim.opt.smarttab = true
    vim.opt.splitright = true
    vim.opt.swapfile = false
    vim.opt.undofile = true
    vim.opt.ignorecase = true
    vim.opt.smartcase = true
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
    require('mini.pick').setup()
    require('mini.fuzzy').setup()
    require('mini.visits').setup()
    require('mini.diff').setup()
    -- only use visits as manual labeling
    vim.g.minivisits_disable = true
end)

-- undotree, use neovim builtin undotree plugin
later(function()
    vim.cmd("packadd nvim.undotree")
end)

-- snippets and completion
later(function()
    vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
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
    require('mini.snippets').start_lsp_server()
    require('mini.completion').setup()
    -- remap keymaps for mini.completion, tab is actually acting really nice
    local map_multistep = require('mini.keymap').map_multistep
    map_multistep('i', '<Tab>', { 'pmenu_next' })
    map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
    map_multistep('i', '<CR>', { 'pmenu_accept' })
end)

-- lsp config
later(function()
    add({
        source = "mason-org/mason-lspconfig.nvim"
    })
    add({
        source = "mason-org/mason.nvim"
    })
    add({
        source = "neovim/nvim-lspconfig"
    })

    require("mason").setup()
    require("mason-lspconfig").setup()
end)

-- dap config
later(function()
    add({ source = "https://codeberg.org/mfussenegger/nvim-dap" })
    add({ source = "https://github.com/igorlfs/nvim-dap-view", tag = '1.*' })
    add({ source = "https://github.com/jay-babu/mason-nvim-dap.nvim" })
    require("mason-nvim-dap").setup({
        handlers = {}
    })
end)

-- java specific package
later(function()
    add({
        source = 'https://github.com/JavaHello/spring-boot.nvim',
        tag = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0',
    })
    add({ source = 'https://github.com/MunifTanjim/nui.nvim', })
    add({ source = 'https://github.com/mfussenegger/nvim-dap', })
    add({ source = 'https://github.com/nvim-java/nvim-java', })

    require('java').setup({
        -- Startup checks
        checks = {
            nvim_version = true,        -- Check Neovim version
            nvim_jdtls_conflict = true, -- Check for nvim-jdtls conflict
        },

        -- Extensions
        lombok = {
            enable = true,
        },

        java_test = {
            enable = true,
        },

        java_debug_adapter = {
            enable = true,
        },

        spring_boot_tools = {
            enable = true,
        },

        -- Logging
        log = {
            use_console = true,
            use_file = true,
            level = 'info',
            log_file = vim.fn.stdpath('state') .. '/nvim-java.log',
            max_lines = 1000,
            show_location = false,
        },
    })

    vim.lsp.config('jdtls', {
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
    })
    vim.lsp.enable('jdtls')
end)

-- nvim-treesitter
later(function()
    add({
        source = "arborist-ts/arborist.nvim",
    })
    require('arborist').setup({
        prefer_wasm = false,
        ensure_installed = { "c", "cpp", "cuda", "python", "java", "lua", "markdown" },
    })
end)

-- keybindings
later(function()
    local mini_pick_hidden = function()
        require('mini.pick').builtin.cli({
            command = { 'fd', '-u', '--type', 'f', '--type', 'd', '-I', '-i' }
        })
    end
    -- leader key fall back
    vim.keymap.set({ 'n', 'v' }, "<leader><leader>", " ", { desc = "just insert the space" })

    -- lsp diagnose
    vim.keymap.set('n', '<leader>h', vim.diagnostic.open_float, { desc = "open diagnostic info" })
    vim.keymap.set('n', '<leader>l', vim.lsp.buf.format, { desc = "format buffer with lsp" })

    -- mini.visit
    vim.keymap.set("n", "<leader>a", function() require('mini.visits').add_label("core") end, { desc = "add label" })
    vim.keymap.set("n", "<leader>d", function() require('mini.visits').remove_label("core") end, { desc = "delete label" })
    vim.keymap.set("n", "<leader>e", function() require('mini.visits').select_path(nil, { filter = "core" }) end,
        { desc = "select label" })

    -- deal with file
    vim.keymap.set('n', '<leader>f', mini_pick_hidden, { desc = 'Open file finder' })
    vim.keymap.set('n', '<leader>u', ':Undotree<cr>', { desc = 'Open undotree', silent = true })
    vim.keymap.set('n', '<leader>/', ':grep ', { desc = 'Use grep to search string' })
    vim.keymap.set('n', '<leader>?', ':Pick grep<cr>', { desc = 'Use fzf style grep to search string' })
    vim.keymap.set('n', '<leader>r', ':Pick resume<cr>', { desc = 'Reuse last fzf picker' })

    -- debugging
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
