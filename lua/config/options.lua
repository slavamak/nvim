vim.g.mapleader = ' '
vim.g.border_chars = 'rounded'

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.colorcolumn = '100'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.breakindent = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '▸ ' }
vim.opt.cursorline = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.showmode = true
vim.opt.laststatus = 0

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.cache/nvim/undodir'

vim.opt.spelllang = 'ru_ru,en_us'
vim.opt.spell = true

vim.opt.termguicolors = true
vim.opt.updatetime = 300

vim.filetype.add {
  filename = {
    hosts = 'ini',
  },
  pattern = {
    ['.*/ansible/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*/handlers/.*%.ya?ml'] = 'yaml.ansible',
  },
}
