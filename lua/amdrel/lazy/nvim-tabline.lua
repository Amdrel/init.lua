return {
	"crispgm/nvim-tabline",
	dependencies = {
		-- "nvim-tree/nvim-web-devicons",
	},
	opts = {
		show_index = true, -- show tab index
		show_modify = true, -- show buffer modification indicator
		show_icon = false, -- show file extension icon
		fnamemodify = ":t", -- file name modifier
		modify_indicator = "[+]", -- modify indicator
		no_name = "No name", -- no name buffer name
		brackets = { "[", "]" }, -- file name brackets surrounding
		inactive_tab_max_length = 0, -- max length of inactive tab titles, 0 to ignore
	},

	config = function(_, opts)
		require("tabline").setup(opts)
	end,
}
