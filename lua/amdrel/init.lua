require("amdrel.set")
require("amdrel.remap")
require("amdrel.lazy_init")

local augroup = vim.api.nvim_create_augroup
local AmdrelGroup = augroup("Amdrel", {})
local YankGroup = augroup("HighlightYank", {})

local autocmd = vim.api.nvim_create_autocmd

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

vim.filetype.add({
	pattern = {
		[".*%.blade%.php"] = "blade",
	},
})

autocmd("TextYankPost", {
	group = YankGroup,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = AmdrelGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd({ "BufNewFile", "BufRead" }, {
	group = AmdrelGroup,
	pattern = "*.vue",
	callback = function()
		vim.opt.filetype = "html"
	end,
})

autocmd({ "VimLeave" }, {
	group = AmdrelGroup,
	pattern = "*",
	callback = function()
		vim.opt.guicursor = "a:hor20"
	end,
})

autocmd("LspAttach", {
	group = AmdrelGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

vim.g.netrw_browse_split = 0
