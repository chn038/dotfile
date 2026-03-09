-- open all fold by zn and undo by zi
-- toggle fold by hovering and pressing za
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git', 'clone', '--filter=blob:none',
    'https://github.com/nvim-mini/mini.nvim', mini_path
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })

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
    vim.opt.scrolloff = 20
end)

-- initial call
now(function()
    require('mini.statusline').setup()
    require('mini.tabline').setup()
    require('mini.notify').setup()
    require('mini.icons').setup()
    add({
        source = "rose-pine/neovim",
        name = "rose-pine"
    })
    vim.cmd('colorscheme rose-pine')

end)

-- regarding to mini
later(function()
    require('mini.completion').setup()
    require('mini.snippets').setup()
    require('mini.diff').setup()
    require('mini.git').setup()
    require('mini.pick').setup()
    require('mini.fuzzy').setup()
end)

-- undotree
later(function()
    add({
        source = 'mbbill/undotree'
    })
end)

-- lsp config
later(function()
    add({
        source = "williamboman/mason.nvim"
    })
    add({
        source = "williamboman/mason-lspconfig.nvim"
    })
    add({
        source = "neovim/nvim-lspconfig"
    })
    require("mason").setup()
    require("mason-lspconfig").setup()
    vim.lsp.enable("clangd")
    vim.lsp.enable("pylsp")
    vim.lsp.enable("nixd")
    vim.lsp.enable("lua_ls")
    vim.lsp.enable("texlab")
end)

-- gen.nvim
later(function()
    add({
        source = "David-Kunz/gen.nvim",
    })
    local opts = {
        model = "gemma3n:e4b", -- The default model to use.
        quit_map = "q", -- set keymap to close the response window
        retry_map = "<c-r>", -- set keymap to re-send the current prompt
        accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
        host = "localhost", -- The host running the Ollama service.
        port = "11434", -- The port on which the Ollama service is listening.
        display_mode = "vertical-split", -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
        show_prompt = true, -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
        show_model = true, -- Displays which model you are using at the beginning of your chat session.
        no_auto_close = true, -- Never closes the window automatically.
        file = true, -- Write the payload to a temporary file to keep the command short.
        hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
        init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
        -- Function to initialize Ollama
        command = function(options)
            local body = {model = options.model, stream = true}
            return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
        end,
        -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
        -- This can also be a command string.
        -- The executed command must return a JSON object with { response, context }
        -- (context property is optional).
        -- list_models = '<omitted lua function>', -- Retrieves a list of model names
        result_filetype = "markdown", -- Configure filetype of the result buffer
        debug = false -- Prints errors and the command which is run.
    }
    require('gen').setup(opts)
end)

-- render-markdown.nvim
later(function()
    add({
    source = 'MeanderingProgrammer/render-markdown.nvim',
    depends = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    })
end)

-- nvim-treesitter
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd("TSUpdate") end}
    })
    require'nvim-treesitter'.setup {
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath('data') .. '/site'
    }
    require'nvim-treesitter'.install({ 'python', 'c', 'cpp', 'cuda', 'lua', 'markdown', 'markdown-inline'}, {generate=true, summary=true})
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'python', 'c', 'cpp', 'cuda', 'lua', 'markdown' },
      callback = function()
          vim.treesitter.start()
          vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.wo[0][0].foldmethod = 'expr'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
end)

-- grapple
later(function()
    add({
        source = "cbochs/grapple.nvim",
        depends = {
            "nvim-tree/nvim-web-devicons"
        },
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
    vim.keymap.set({'n', 'v'}, "<leader><leader>", " ", { desc = "just insert the space" })

    vim.keymap.set({'n'}, '<leader>h', vim.diagnostic.open_float, { desc = "open diagnostic in float window" })

    -- grapple
    vim.keymap.set("n", "<leader>m", require("grapple").toggle, { desc = "toggle grapple here" })
    vim.keymap.set("n", "<leader>l", require("grapple").toggle_tags, { desc = "show the tag list" })
    vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>", { desc = "goto first tag" })
    vim.keymap.set("n", "<leader>2", "<cmd>Grapple select index=2<cr>", { desc = "goto second tag" })
    vim.keymap.set("n", "<leader>3", "<cmd>Grapple select index=3<cr>", { desc = "goto third tag" })
    vim.keymap.set("n", "<leader>4", "<cmd>Grapple select index=4<cr>", { desc = "goto forth tag" })

    -- deal with file
    vim.keymap.set('n', '<leader>ff', mini_pick_hidden, { desc = 'Open file finder'})
    vim.keymap.set('n', '<leader>fu', ':UndotreeToggle<cr>', { desc = 'Open undotree', silent = true })

    -- deal with git
    vim.keymap.set('n', '<leader>gg', ':Git ', { desc = "Open git" })

    -- deal with ai
    vim.keymap.set({'n', 'v'}, "<leader>oo", ":Gen<CR>", { desc = "gen"})
    vim.keymap.set({'n', 'v'}, "<leader>c", ":Gen Chat<CR>", { desc = "gen chat"})
    vim.keymap.set('n', "<leader>os", require('gen').select_model, { desc = "gen select model"})

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
