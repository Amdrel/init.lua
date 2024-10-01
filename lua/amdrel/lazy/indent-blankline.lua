return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},

    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require("ibl.hooks")

        -- Create the highlight groups in the highlight setup hook, so they are
        -- reset every time the colorscheme changes.
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#2a090c" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#2b1f08" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#041c2f" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#271a0c" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#182310" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#220a29" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#0e2325" })
        end)

        require("ibl").setup({
            indent = {
                highlight = highlight
            },
            scope = {
                show_start = true,
                show_end = true,
            }
        })

        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end
}
