return {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    lazy = false,
    keys = {
        {
            "<leader>xw",
            "<cmd>Trouble diagnostics toggle<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xW",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>xs",
            "<cmd>Trouble symbols toggle focus=false<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>xl",
            "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
            desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
            "<leader>xL",
            "<cmd>Trouble loclist toggle<cr>",
            desc = "Location List (Trouble)",
        },
        {
            "<leader>xQ",
            "<cmd>Trouble qflist toggle<cr>",
            desc = "Quickfix List (Trouble)",
        },
        {
            "gR",
            "<cmd>Trouble lsp_references<cr>",
            desc = "References (Trouble)",
        },
        {
            "gD",
            "<cmd>Trouble lsp_definitions<cr>",
            desc = "Definitions (Trouble)",
        },
        {
            "gdt",
            "<cmd>Trouble lsp_type_definitions<cr>",
            desc = "Type definitions (Trouble)"
        },
        {
            "<leader>xx",
            "<cmd>Trouble close<cr>",
            desc = "Close Trouble"
        },
    },
}
