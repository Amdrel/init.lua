vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80,100,120"
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.termguicolors = true
vim.opt.updatetime = 50

vim.opt.exrc = true

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
      name = "win32yank";
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
