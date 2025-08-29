return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			vue = { "prettier" },
			jsx = { "prettier" },
			tsx = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
			rust = { "rustfmt", lsp_format = "fallback" },
			php = { "pint" },
			sql = { "pg_format" },
		},
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return {
				-- These options will be passed to conform.format()
				timeout_ms = 20000,
				lsp_format = "fallback",
			}
		end,
	},

	config = function(_, opts)
		require("conform").setup(opts)
		require("conform").formatters.pg_format = { args = { "-u", "2" } }
	end,
}
