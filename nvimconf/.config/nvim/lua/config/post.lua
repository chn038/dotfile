vim.cmd("colorscheme kanagawa")

-- leader key fall back
vim.keymap.set({'n', 'v'}, "<leader><leader>", " ", { desc = "just insert the space" })

-- general with lsp
--'omnifunc' is set to vim.lsp.omnifunc(), use i_CTRL-X_CTRL-O to trigger completion.
-- 'tagfunc' is set to vim.lsp.tagfunc(). This enables features like go-to-definition, :tjump, and keymaps like CTRL-], CTRL-W_], CTRL-W_} to utilize the language server.
-- 'formatexpr' is set to vim.lsp.formatexpr(), so you can format lines via gq if the language server supports it.
-- To opt out of this use gw instead of gq, or clear 'formatexpr' on LspAttach.
-- K is mapped to vim.lsp.buf.hover() unless 'keywordprg' is customized or a custom keymap for K exists.
-- GLOBAL DEFAULTS
-- grr gra grn gri i_CTRL-S These GLOBAL keymaps are created unconditionally when Nvim starts:
-- "grn" is mapped in Normal mode to vim.lsp.buf.rename()
-- "gra" is mapped in Normal and Visual mode to vim.lsp.buf.code_action()
-- "grr" is mapped in Normal mode to vim.lsp.buf.references()
-- "gri" is mapped in Normal mode to vim.lsp.buf.implementation()
-- "gO" is mapped in Normal mode to vim.lsp.buf.document_symbol()
-- CTRL-S is mapped in Insert mode to vim.lsp.buf.signature_help()
vim.keymap.set({'n'}, '<leader>h', vim.diagnostic.open_float, { desc = "open diagnostic in float window" })

-- deal with file
vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files hidden=true<cr>', { desc = 'Open fzf file finder'})
vim.keymap.set('n', '<leader>fg', '<cmd>FzfLua git_files hidden=true<cr>', { desc = 'Open fzf git file finder'})
vim.keymap.set('n', '<leader>fu', function() require('undotree').toggle() end, { noremap = true, silent = true })

-- deal with code, debug adapter protocol, start with d
vim.keymap.set('n', '<leader>db', function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint"})
vim.keymap.set('n', '<leader>dn', function() require("dap").continue() end, { desc = "Toggle breakpoint"})
vim.keymap.set('n', "<leader>dd", function() require("dapui").toggle() end, { desc = "Toggle debug view" })
vim.keymap.set({'n', 'v'}, "<leader>de", function() require("dapui").eval() end, { desc = "Evaluate selection" })

-- deal with git
vim.keymap.set('n', '<leader>gg', "<cmd>Neogit<CR>", { desc = "Open Neogit" })
