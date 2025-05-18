return {
	"supermaven-inc/supermaven-nvim",

	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-,>",
				accept_word = "<C-.>",
			},
			ignore_filetypes = {},
			color = {
				suggestion_color = "#777777",
				cterm = 244,
			},
			log_level = "info",
			disable_inline_completion = false,
			disable_keymaps = false,

			condition = function()
				return false
			end,
		})
	end,
}
