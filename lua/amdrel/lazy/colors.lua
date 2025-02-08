function ColorMyPencils(color)
	color = color or "one_monokai"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#222222" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#212121" })
	vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none" })
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				disable_background = true,
				styles = {
					italic = false,
					transparency = true,
				},
			})
			ColorMyPencils()
		end,
	},
	{
		"cpea2506/one_monokai.nvim",
		config = function()
			require("one_monokai").setup({
				transparent = true,
				colors = {
					green = "#d0d0d0",
					pink = "#e8556b",
				},
				themes = function(colors)
					-- Change highlight of some groups, The key and value will
					-- be passed respectively to "nvim_set_hl".
					return {
						Normal = { bg = colors.lmao },
						DiffChange = { fg = colors.white:darken(0.3) },
						ErrorMsg = { fg = colors.red, standout = true },
						["@lsp.type.keyword"] = { link = "@keyword" },

						-- Adjust some Python color choices I find to be a bit
						-- difficult to read with the default choices.
						["@module.python"] = { fg = colors.lmao },
						["@type.builtin.python"] = { fg = colors.blue },
						["@keyword.type.python"] = { fg = colors.cyan },
						["@string.documentation.python"] = { fg = "#5cb76e" },
					}
				end,
				italics = false,
			})
			ColorMyPencils()
		end,
	},
}
