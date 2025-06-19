return {
	"shortcuts/no-neck-pain.nvim",

	version = "*",

	config = function()
		require("no-neck-pain").setup({
			width = 180,
			autocmds = {
				enableOnVimEnter = false,
				enableOnTabEnter = false,
			},
		})
		vim.keymap.set("n", "<leader>zz", "<cmd>NoNeckPain<CR>")
	end,
}
