return {
    "prichrd/netrw.nvim",
    opts = {
        use_devicons = true,

        mappings = {
            -- Function mappings receive an object describing the node under
            -- the cursor
            ["p"] = function(payload)
                print(vim.inspect(payload))
            end,
        },
    },

    config = function(_, opts)
        require("netrw").setup(opts)
    end
}
