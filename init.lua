if vim.g.vscode then
	require("vscode")
elseif vim.fn.has("unix") == 1 then
	require("amdrel")
else
	require("windows")
end
