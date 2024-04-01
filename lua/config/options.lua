vim.g.mapleader = ' '
vim.g.netrw_browse_split = 0
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.g.border_chars = 'rounded'
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '▸ ' }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.spell = true
vim.opt.spelllang = 'ru_ru,en_us'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = '%f %m %= %Y %p%% %l:%c  '
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.undodir = os.getenv 'HOME' .. '/.cache/nvim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wrap = false
