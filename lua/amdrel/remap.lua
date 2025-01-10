vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", function()
	local oil = require("oil")
	oil.open(oil.get_current_dir())
end)

vim.keymap.set("n", "<leader>e", function()
	vim.diagnostic.open_float()
end)

vim.keymap.set("n", "<leader>E", function()
	local _, win_id = vim.diagnostic.open_float()
	vim.api.nvim_set_current_win(win_id)
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

-- Centering the cursor when jumping around is very neat
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

-- I'm lazy and don't like pressing <C-w>, but also I like my wrist being healthy
vim.keymap.set("n", "<C-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>wincmd j<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>wincmd k<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>wincmd l<CR>")

vim.keymap.set("t", "<C-X>", "<C-\\><C-n>")
vim.keymap.set("i", "<C-H>", "<C-W>")
vim.keymap.set("n", "<M-h>", "<cmd>tabm -1<CR>")
vim.keymap.set("n", "<M-l>", "<cmd>tabm +1<CR>")

-- I never use these for their intended purposes so I'm going to make them useful for me
vim.keymap.set("n", "H", "<cmd>BufSurfBack<CR>")
vim.keymap.set("n", "L", "<cmd>BufSurfForward<CR>")
