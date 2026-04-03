return {
	"nvim-treesitter/nvim-treesitter",

	branch = "main",
	build = ":TSUpdate",

	init = function()
		-- This is basically everything that I use on a semi-regular basis.
		local ensureInstalled = {
			"vimdoc",
			"javascript",
			"typescript",
			"c",
			"lua",
			"rust",
			"jsdoc",
			"bash",
			"gitcommit",
			"php",
			"python",
			"html",
			"blade",
			"php_only",
		}

		-- Identify which parsers are not yet installed.
		local alreadyInstalled = require("nvim-treesitter.config").get_installed()
		local parsersToInstall = vim.iter(ensureInstalled)
			:filter(function(parser)
				return not vim.tbl_contains(alreadyInstalled, parser)
			end)
			:totable()

		require("nvim-treesitter").install(parsersToInstall)
	end,

	config = function()
		require("nvim-treesitter").setup()

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if lang and vim.treesitter.language.add(lang) then
					vim.treesitter.start(args.buf, lang)
				end
			end,
		})
	end,
}
