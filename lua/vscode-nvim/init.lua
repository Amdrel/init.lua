-- This file contains user-specific configurations for the VSCode Neovim plugin.

-- System clipboard integration
if vim.fn.has("unix") == 1 then
	local os = vim.fn.system("uname"):gsub("\n", "")

	if os == "Darwin" then
		vim.opt.clipboard = "unnamed"
	elseif os == "Linux" or os == "FreeBSD" or os == "OpenBSD" or os == "NetBSD" then
		vim.opt.clipboard = "unnamedplus"
	end
elseif vim.fn.executable("win32yank.exe") == 1 then
	vim.opt.clipboard = "unnamedplus"

	vim.g.clipboard = {
		name = "win32yank",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enabled = 0,
	}
end

-- Workaround for vscode-neovim UI desync (issue #2117)

-- 1. Redraw on CursorHold (idle for some time)
local redraw_fix = vim.api.nvim_create_augroup("VSCodeRedrawFix", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
	group = redraw_fix,
	callback = function()
		vim.cmd("silent! mode") -- Triggers a lightweight redraw
	end,
})

-- 2. Redraw immediately after text changes (e.g., visual delete)
local redraw_group = vim.api.nvim_create_augroup("RedrawOnDelete", { clear = true })
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	group = redraw_group,
	callback = function()
		if vim.fn.mode() == "n" then
			vim.cmd("silent! mode") -- Refresh the UI after an insert / delete
		end
	end,
})
