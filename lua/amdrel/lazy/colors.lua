function ColorMyPencils(color)
	color = color or "one_monokai"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#222222" })
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
        end
    },
    {
        "cpea2506/one_monokai.nvim",
        config = function()
            require("one_monokai").setup({
                transparent = true,  -- enable transparent window
                colors = {
                    green = "#d0d0d0",
                },
                themes = function(colors)
                    -- change highlight of some groups,
                    -- the key and value will be passed respectively to "nvim_set_hl"
                    return {
                        Normal = { bg = colors.lmao },
                        DiffChange = { fg = colors.white:darken(0.3) },
                        ErrorMsg = { fg = colors.pink, standout = true },
                        ["@lsp.type.keyword"] = { link = "@keyword" }
                    }
                end,
                italics = false, -- disable italics
            })
            ColorMyPencils()
        end
    },
}
