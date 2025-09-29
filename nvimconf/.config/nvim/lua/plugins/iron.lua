return {
    {
        'willothy/wezterm.nvim',
        config = true
    },
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_auto_open_output = false -- cannot be true if molten_image_provider = "wezterm"
            vim.g.molten_output_show_more = true
            vim.g.molten_image_provider = "wezterm"
            vim.g.molten_output_virt_lines = true
            vim.g.molten_split_direction = "right" --direction of the output window, options are "right", "left", "top", "bottom"
            vim.g.molten_split_size = 40 --(0-100) % size of the screen dedicated to the output window
            vim.g.molten_virt_text_output = true
            vim.g.molten_use_border_highlights = true
            vim.g.molten_virt_lines_off_by_1 = true
            vim.g.molten_auto_image_popup = false
            vim.g.molten_output_win_zindex = 50
        end,
    }
}
