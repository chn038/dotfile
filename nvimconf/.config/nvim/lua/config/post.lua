vim.cmd("colorscheme rose-pine")

-- leader key fall back
vim.keymap.set({'n', 'v'}, "<leader><leader>", " ", { desc = "just insert the space" })
-- general mapping
vim.keymap.set('n', "<leader>a", "<cmd>Grapple toggle<cr>", { desc = "Tag a file" })
vim.keymap.set('n', "<leader>e", "<cmd>Grapple toggle_tags<cr>", { desc = "Toggle tags menu" })
vim.keymap.set('n', "<leader>h", "<cmd>Grapple select index=1<cr>", { desc = "Select first tag" })
vim.keymap.set('n', "<leader>j", "<cmd>Grapple select index=2<cr>", { desc = "Select second tag" })
vim.keymap.set('n', "<leader>k", "<cmd>Grapple select index=3<cr>", { desc = "Select third tag" })
vim.keymap.set('n', "<leader>l", "<cmd>Grapple select index=4<cr>", { desc = "Select fourth tag" })
vim.keymap.set('n', "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Buffer Local Keymaps (which-key)" })

-- deal with file
vim.keymap.set('n', '<leader>fp', '<cmd>NnnPicker %:p:h<cr>', { desc = 'Open nnn file manager' })
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files hidden=true<cr>', { desc = 'Open fzf file finder'})

-- deal with code, general
vim.keymap.set('n', '<leader>cu', function() require('undotree').toggle() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'trigger lsp code action' })
vim.keymap.set('n', '<leader>cl', '<cmd>FzfLua live_grep<cr>', { desc = 'Live grep' })
vim.keymap.set('n', '<leader>cs', '<cmd>FzfLua grep_cword<cr>', { desc = 'grep' })
vim.keymap.set('v', '<leader>cs', '<cmd>FzfLua grep_visual<cr>', { desc = 'grep' })

-- deal with code, using trouble, start with x
vim.keymap.set('n', '<leader>xx', "<cmd>Trouble diagnostics toggle focus=false<cr>", { desc = "toggle trouble" })
vim.keymap.set('n', '<leader>xd', "<cmd>Trouble lsp_declarations toggle<cr>", { desc = "toggle declarations"})
vim.keymap.set('n', '<leader>xD', "<cmd>Trouble lsp_definitions toggle<cr>", { desc = "toggle lsp_definitions"})
vim.keymap.set('n', '<leader>xs', "<cmd>Trouble lsp_document_symbols toggle<cr>", { desc = "toggle document symbols"})
vim.keymap.set('n', '<leader>xI', "<cmd>Trouble lsp_implementations toggle<cr>", { desc = "toggle implementations" })
vim.keymap.set('n', '<leader>xi', "<cmd>Trouble lsp_incoming_calls toggle<cr>", { desc = "toggle incoming calls" })
vim.keymap.set('n', '<leader>xo', "<cmd>Trouble lsp_outgoing_calls toggle<cr>", { desc = "toggle outgoing calls" })
vim.keymap.set('n', "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", { desc = "toggle references" })
vim.keymap.set('n', "<leader>xt", "<cmd>Trouble lsp_type_definitions toggle<cr>", { desc = "toggle type definitions" })

-- deal with code, molten, start with m
vim.keymap.set("n", "<leader>mm", "<cmd>MoltenInit<CR>", { desc = "Initialize the plugin" })
vim.keymap.set("n", "<leader>me", "<cmd>MoltenEvaluateOperator<CR>", { desc = "run operator selection" })
vim.keymap.set("n", "<leader>ml", "<cmd>MoltenEvaluateLine<CR>", { desc = "evaluate line" })
vim.keymap.set("n", "<leader>mc", "<cmd>MoltenReevaluateCell<CR>", { desc = "re-evaluate cell" })
vim.keymap.set("v", "<leader>m", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "evaluate visual selection" })
vim.keymap.set('n', "<leader>ma", "<cmd>MoltenReevaluateAll<CR>", { desc = "re evaluate all" })
vim.keymap.set("n", "<leader>ms", "<cmd>MoltenExportOutput!<CR>", { desc = "export output" })
vim.keymap.set("n", "<leader>mi", "<cmd>MoltenImportOutput<CR>", { desc = "import output" })
vim.keymap.set("n", "<leader>mo", ":noautocmd MoltenEnterOutput<CR>", { desc = "enter output" })

-- deal with code, debug adapter protocol, start with d
vim.keymap.set('n', '<leader>db', function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint"})
vim.keymap.set('n', '<leader>dn', function() require("dap").continue() end, { desc = "Toggle breakpoint"})
vim.keymap.set('n', "<leader>dd", function() require("dapui").toggle() end, { desc = "Toggle debug view" })
vim.keymap.set({'n', 'v'}, "<leader>de", function() require("dapui").eval() end, { desc = "Evaluate selection" })

-- deal with git
vim.keymap.set('n', '<leader>gg', "<cmd>Neogit<CR>", { desc = "Open Neogit" })

-- deal with terminal
vim.keymap.set({'n', 't'}, "<C-h><C-h>", "<cmd>ToggleTerm<CR>", { desc = "toggle terminal" })
vim.keymap.set('v', "<leader>tv", "<cmd>ToggleTermSendVisualSelection<CR>", { desc = "Send line into terminal" })
vim.keymap.set('n', "<leader>ts", "<cmd>TermSelect<CR>", { desc = "Select from all terminal" })
vim.keymap.set('n', "<leader>tn", "<cmd>TermNew<CR>", { desc = "Create new terminal" })
-- deal with ai, start with ta
vim.keymap.set('n', "<leader>taa", "<cmd>CodeCompanionActions<CR>", { desc = "Call action pallet" })
vim.keymap.set({'n', 'v'}, "<C-j><C-j>", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle chat buffer"})
vim.keymap.set({'n', 'v'}, "<C-j><C-i>", ":CodeCompanion", { desc = "Call inline assistant" })
