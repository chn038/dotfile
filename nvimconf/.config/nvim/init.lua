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
        source = "catppuccin/nvim",
        name = "catppuccin"
    })
    vim.cmd('colorscheme catppuccin-macchiato')
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
    vim.lsp.config('pylsp', {
        settings = {
            pylsp = {
                plugins = {
                    ruff = {
                        enabled = true,
                    },
                }
            }
        }
    })

    vim.lsp.enable("clangd")
    vim.lsp.enable("pylsp")
    vim.lsp.enable("rnix")
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

-- jupynium.nvim
later(function()
    add({
        source = 'kiyoon/jupynium.nvim',
    })
    require("jupynium").setup({
        --- For Conda environment named "jupynium",
        -- python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },
        python_host = "python3",

        default_notebook_URL = "localhost:8888/nbclassic",

        -- Write jupyter command but without "notebook"
        -- When you call :JupyniumStartAndAttachToServer and no notebook is open,
        -- then Jupynium will open the server for you using this command. (only when notebook_URL is localhost)
        jupyter_command = "jupyter",
        --- For Conda, maybe use base environment
        --- then you can `conda install -n base nb_conda_kernels` to switch environment in Jupyter Notebook
        -- jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },

        -- Used when notebook is launched by using jupyter_command.
        -- If nil or "", it will open at the git directory of the current buffer,
        -- but still navigate to the directory of the current buffer. (e.g. localhost:8888/nbclassic/tree/path/to/buffer)
        notebook_dir = nil,

        -- Used to remember the last session (password etc.).
        -- e.g. '~/.mozilla/firefox/profiles.ini'
        -- or '~/snap/firefox/common/.mozilla/firefox/profiles.ini'
        firefox_profiles_ini_path = nil,
        -- nil means the profile with Default=1
        -- or set to something like 'default-release'
        firefox_profile_name = nil,

        -- Open the Jupynium server if it is not already running
        -- which means that it will open the Selenium browser when you open this file.
        -- Related command :JupyniumStartAndAttachToServer
        auto_start_server = {
            enable = false,
            file_pattern = { "*.ju.*" },
        },

        -- Attach current nvim to the Jupynium server
        -- Without this step, you can't use :JupyniumStartSync
        -- Related command :JupyniumAttachToServer
        auto_attach_to_server = {
            enable = true,
            file_pattern = { "*.ju.*", "*.md" },
        },

        -- Automatically open an Untitled.ipynb file on Notebook
        -- when you open a .ju.py file on nvim.
        -- Related command :JupyniumStartSync
        auto_start_sync = {
            enable = false,
            file_pattern = { "*.ju.*", "*.md" },
        },

        -- Automatically keep filename.ipynb copy of filename.ju.py
        -- by downloading from the Jupyter Notebook server.
        -- WARNING: this will overwrite the file without asking
        -- Related command :JupyniumDownloadIpynb
        auto_download_ipynb = true,

        -- Automatically close tab that is in sync when you close buffer in vim.
        auto_close_tab = true,

        -- Always scroll to the current cell.
        -- Related command :JupyniumScrollToCell
        autoscroll = {
            enable = true,
            mode = "always", -- "always" or "invisible"
            cell = {
                top_margin_percent = 20,
            },
        },

        scroll = {
            page = { step = 0.5 },
            cell = {
                top_margin_percent = 20,
            },
        },

        -- Files to be detected as a jupynium file.
        -- Add highlighting, keybindings, commands (e.g. :JupyniumStartAndAttachToServer)
        -- Modify this if you already have lots of files in Jupytext format, for example.
        jupynium_file_pattern = { "*.ju.*" },

        use_default_keybindings = false,
        textobjects = {
            use_default_keybindings = true,
        },

        syntax_highlight = {
            enable = true,
        },

        -- Dim all cells except the current one
        -- Related command :JupyniumShortsightedToggle
        shortsighted = false,

        -- Configure floating window options
        -- Related command :JupyniumKernelHover
        kernel_hover = {
            floating_win_opts = {
                max_width = 84,
                border = "none",
            },
        },

        notify = {
            ignore = {
                -- "download_ipynb",
                -- "error_download_ipynb",
                -- "attach_and_init",
                -- "error_close_main_page",
                -- "notebook_closed",
            },
        },
    })

    -- You can link highlighting groups.
    -- This is the default (when colour scheme is unknown)
    -- Try with CursorColumn, Pmenu, Folded etc.
    vim.cmd [[
    hi! link JupyniumCodeCellSeparator CursorLine
    hi! link JupyniumMarkdownCellSeparator CursorLine
    hi! link JupyniumMarkdownCellContent CursorLine
    hi! link JupyniumMagicCommand Keyword
    ]]

    -- Please share your favourite settings on other colour schemes, so I can add defaults.
    -- Currently, tokyonight is supported.
end)

-- nvim-treesitter
later(function()
    add({
        source = "nvim-treesitter/nvim-treesitter",
        hooks = { post_checkout = function() vim.cmd("TSUpdate") end}
    })
    require'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = {},

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
            enable = true,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
    }
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
    vim.keymap.set("n", "<leader>mm", require("grapple").toggle, { desc = "toggle grapple here" })
    vim.keymap.set("n", "<leader>ml", require("grapple").toggle_tags, { desc = "show the tag list" })
    vim.keymap.set("n", "<leader>mq", "<cmd>Grapple select index=1<cr>", { desc = "goto first tag" })
    vim.keymap.set("n", "<leader>mw", "<cmd>Grapple select index=2<cr>", { desc = "goto second tag" })
    vim.keymap.set("n", "<leader>me", "<cmd>Grapple select index=3<cr>", { desc = "goto third tag" })
    vim.keymap.set("n", "<leader>mr", "<cmd>Grapple select index=4<cr>", { desc = "goto forth tag" })

    -- deal with file
    vim.keymap.set('n', '<leader>ff', mini_pick_hidden, { desc = 'Open file finder'})
    vim.keymap.set('n', '<leader>fu', ':UndotreeToggle<cr>', { desc = 'Open undotree', silent = true })

    -- deal with git
    vim.keymap.set('n', '<leader>gg', ':Git ', { desc = "Open git" })

    -- deal with ai
    vim.keymap.set({'n', 'v'}, "<leader>oo", ":Gen<CR>", { desc = "gen"})
    vim.keymap.set({'n', 'v'}, "<leader>oc", ":Gen Chat<CR>", { desc = "gen chat"})
    vim.keymap.set('n', "<leader>os", require('gen').select_model, { desc = "gen select model"})

    -- deal with jupynium
    vim.keymap.set('n', "<leader>ra", ':JupyniumStartAndAttachToServer<CR>', { desc = "attach" })
    vim.keymap.set('n', "<leader>rl", ':JupyniumLoadFromIpynbTabAndStartSync ', { desc = "load from tab" })
    vim.keymap.set('n', "<leader>rs", ':JupyniumStartSync<CR>', { desc = "attach" })
    vim.keymap.set('n', "<leader>sc", ':JupyniumExecuteSelectedCells<CR>', { desc = "execute" })
    vim.keymap.set('n', "<leader>rR", ':JupyniumKernelRestart<CR>', { desc = "restart" })
    vim.keymap.set('n', "<leader>ri", ':JupyniumKernelInterrupt<CR>', { desc = "Interrupt" })
    vim.keymap.set('n', "<leader>rc", ':JupyniumKernelSelect<CR>', { desc = "select kernel" })
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
