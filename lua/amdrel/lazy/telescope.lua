return {
	"nvim-telescope/telescope.nvim",

	branch = "master",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"./node_modules/*",
					"node_modules",
					"./vendor/*",
					"vendor",
					"./cache/*",
					"cache",
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					-- "--hidden",
					-- "--no-ignore-vcs",
				},
			},
		})

		local builtin = require("telescope.builtin")
		local utils = require("telescope.utils")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", function()
			-- TODO: Set CWD based on current buffer location (closest .git).
			builtin.git_files({
				recurse_submodules = false,
				show_untracked = true,
				use_git_root = false,
			})
		end, {})
		vim.keymap.set("n", "<M-p>", function()
			builtin.find_files({ no_ignore = true, hidden = true })
		end, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			builtin.grep_string({
				search = vim.fn.input("Grep > "),
				use_regex = false,
			})
		end)
		vim.keymap.set("n", "<leader>pS", function()
			builtin.grep_string({
				search = vim.fn.input("Regex Grep > "),
				use_regex = true,
			})
		end)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

		-- Custom grep command that lets me search subdirectories.
		--
		-- Note: This currently doesn't expand aliases like `~`. Escaping of
		-- spaces in paths does work, though.
		vim.api.nvim_create_user_command("Grep", function(args)
			if #args.fargs == 0 then
				print("Usage: Grep <search string> [directory]")
				return
			end

			local opts = {
				search = args.fargs[1],
				use_regex = false,
			}
			if #args.fargs > 1 then
				local buffer_dir = utils.buffer_dir()
				local dir = args.fargs[2]
				opts.cwd = vim.fs.joinpath(buffer_dir, dir)
			end
			builtin.grep_string(opts)
		end, {
			desc = "Grep for strings in the project",
			nargs = "*",
		})
	end,
}
