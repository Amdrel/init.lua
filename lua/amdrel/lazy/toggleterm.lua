return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",

        config = function ()
            require("toggleterm").setup({
                direction = 'float',
            })

            vim.keymap.set({"n", "t"}, "<C-`>", "<cmd>ToggleTerm<CR>")
            vim.keymap.set({"n", "t"}, "<C-s>", "<cmd>ToggleTerm<CR>")
        end,
    }
}
