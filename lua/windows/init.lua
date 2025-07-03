-- This file contains user-specific configurations for Windows. I cannot use my
-- main configuration with Windows since half my plugins malfunction there. I
-- just use neovim for quick edits on Windows anyways, so it's no loss.

-- System clipboard integration
if vim.fn.executable("win32yank.exe") == 1 then
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
