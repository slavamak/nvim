vim.g.mapleader = ' '
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '▸ ' }
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 4
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.spell = true
vim.opt.spelllang = 'ru_ru,en_us' vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = '%f %m %= %Y %p%% %l:%c  '
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.undodir = os.getenv 'HOME' .. '/.cache/nvim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wrap = false

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape' })
vim.keymap.set({ 'n', 'i' }, '<Esc>', '<Cmd>noh<Cr><Esc>', { desc = 'Clear the search highlight' })
vim.keymap.set({ 'n', 'v' }, '<Leader>y', [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>Y', [["+Y]], { desc = 'Copy a line to system clipboard' })
vim.keymap.set('x', '<Leader>p', [["_dP]], { desc = 'Paste yanked text without affecting registers' })
vim.keymap.set({ 'n', 'v' }, '<Leader>d', [["_d]], { desc = 'Delete selection without affecting registers' })
vim.keymap.set('v', 'J', ":m '>+1<Cr>gv=gv", { desc = 'Move selection down'})
vim.keymap.set('v', 'K', ":m '>-2<Cr>gv=gv", { desc = 'Move selection up'})
vim.keymap.set('n', 'л', 'gk', { desc = 'Move cursor up' })
vim.keymap.set('n', 'о', 'gj', { desc = 'Move cursor down' })
vim.keymap.set('n', 'р', 'h', { desc = 'Move cursor left' })
vim.keymap.set('n', 'д', 'l', { desc = 'Move cursor right' })
vim.keymap.set('n', '<Leader>p', '<Cmd>Ex<Cr>', { desc = 'Open Netrw' })
