return {
	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")

		vim.lsp.config("phpactor", {
			cmd = { "phpactor", "language-server" },
			filetypes = { "php" },

			-- When working on Mediawiki I like having my cwd match the
			-- extension that I'm working on, but I still want the LSP to be
			-- useful. This is so that telescope works correctly mainly as the
			-- submodules are ignored.
			--
			-- This override checks if I'm in Mediawiki, and if so, sets the
			-- LSP cwd to the core repository.
			root_dir = function(bufnr, on_dir)
				local fname = vim.api.nvim_buf_get_name(bufnr)
				local cwd = assert(vim.uv.cwd())

				local mediawiki_path = vim.fs.joinpath(vim.fn.expand("~"), "src/wikimedia/mediawiki")
				if string.sub(cwd, 1, #mediawiki_path) == mediawiki_path then
					on_dir(mediawiki_path)
					return
				end

				local root = vim.fs.root(fname, { "composer.json", ".git", ".phpactor.json", ".phpactor.yml" })

				-- Prefer cwd if root is a descendant.
				on_dir(root and vim.fs.relpath(cwd, root) and cwd)
			end,
		})

		vim.lsp.config("cssls", {
			-- Workaround Tailwind rules not being found.
			settings = { css = { lint = { unknownAtRules = "ignore" } } },
		})

		vim.lsp.config("ts_ls", {
			-- The TypeScript LSP isn't loading unless I add the 'on_attach'
			-- for some reason.
			on_attach = function(client)
				require("lsp_signature").on_attach()
			end,
		})

		vim.lsp.config("lua_ls", {
			-- Make the Lua LSP work with tests.
			settings = {
				Lua = {
					runtime = { version = "Lua 5.1" },
					diagnostics = {
						globals = { "vim", "it", "describe", "before_each", "after_each" },
					},
				},
			},
		})

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup()

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				-- ["<Tab>"] = cmp.mapping.confirm({ select = true }),
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
