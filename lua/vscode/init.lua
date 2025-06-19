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
