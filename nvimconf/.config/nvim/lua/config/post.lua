vim.cmd("colorscheme rose-pine")

-- leader key fall back
vim.keymap.set({'n', 'v'}, "<leader><leader>", " ", { desc = "just insert the space" })

-- deal with file
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files hidden=true<cr>', { desc = 'Open fzf file finder'})
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua git_files hidden=true<cr>', { desc = 'Open fzf git file finder'})

-- deal with code, general
vim.keymap.set('n', '<leader>cu', function() require('undotree').toggle() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'trigger lsp code action' })

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

-- deal with ai, start with ta
vim.keymap.set('n', "<leader>taa", "<cmd>CodeCompanionActions<CR>", { desc = "Call action pallet" })
vim.keymap.set({'n', 'v'}, "<C-j><C-j>", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "Toggle chat buffer"})
vim.keymap.set({'n', 'v'}, "<C-j><C-i>", ":CodeCompanion", { desc = "Call inline assistant" })
