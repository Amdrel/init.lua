if vim.g.vscode then
	require("vscode-nvim")
elseif vim.fn.has("unix") == 1 then
	require("amdrel")
else
	require("windows")
end
