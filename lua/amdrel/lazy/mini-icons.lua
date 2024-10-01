return {
	"echasnovski/mini.icons",
	version = "*",
	opts = {
		-- Icon style: 'glyph' or 'ascii'
		style = "glyph",

		-- Customize per category. See `:h MiniIcons.config` for details.
		default = {},
		directory = {},
		extension = {},
		file = {},
		filetype = {},
		lsp = {},
		os = {},

		-- Control which extensions will be considered during "file" resolution
		use_file_extension = function(ext, file)
			return true
		end,
	},

	config = function(_, opts)
		require("mini.icons").setup(opts)
	end,
}
