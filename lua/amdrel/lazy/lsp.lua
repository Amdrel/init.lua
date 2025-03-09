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
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"css_variables",
				"cssls",
				"eslint",
				"gopls",
				"html",
				"lua_ls",
				"phpactor",
				"pyright",
				"rust_analyzer",
				"tailwindcss",
				"ts_ls",
				"vuels",
			},

			handlers = {
				-- Default handler (optional)
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,

				-- Make the Lua LSP work with tests.
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,

				-- The TypeScript LSP isn't loading unless I add the
				-- 'on_attach' for some reason.
				["ts_ls"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.ts_ls.setup({
						capabilities = capabilities,

						on_attach = function(client)
							require("lsp_signature").on_attach()
						end,
					})
				end,

				-- Workaround Tailwind rules not being found.
				["cssls"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.cssls.setup({
						settings = { css = { lint = { unknownAtRules = "ignore" } } },
					})
				end,

				-- When working on Mediawiki I like having my cwd match the
				-- extension that I'm working on, but I still want the LSP to
				-- be useful. This is so that telescope works correctly mainly
				-- as the submodules are ignored.
				--
				-- This override checks if I'm in Mediawiki, and if so, sets
				-- the LSP cwd to the core repository.
				["phpactor"] = function()
					local lspconfig = require("lspconfig")

					lspconfig.phpactor.setup({
						capabilities = capabilities,

						root_dir = function(fname)
							local cwd = vim.fn.getcwd()
							local home_path = vim.fn.expand("~")
							local mediawiki_path = vim.fs.joinpath(home_path, "src/wikimedia/mediawiki")

							if string.sub(cwd, 1, #mediawiki_path) == mediawiki_path then
								return mediawiki_path
							end

							-- Fallback to standard behavior for other PHP apps.
							return lspconfig.util.root_pattern(".git", "composer.json")(fname)
								or lspconfig.util.path.dirname(fname)
						end,
					})
				end,
			},
		})

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
				["<Tab>"] = cmp.mapping.confirm({ select = true }),
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
