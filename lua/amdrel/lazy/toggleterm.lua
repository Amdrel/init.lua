return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",

		config = function()
			require("toggleterm").setup({
				direction = "horizontal",
				size = 25,
			})

			vim.keymap.set({ "n", "t" }, "<C-`>", "<cmd>ToggleTerm<CR>")
			vim.keymap.set({ "n", "t" }, "<C-s>", "<cmd>ToggleTerm<CR>")
		end,
	},
}
