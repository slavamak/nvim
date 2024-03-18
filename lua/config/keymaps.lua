local bind = require('util').bind()

bind('n', '<Leader>pv', '<Cmd>Neotree toggle reveal<Cr>', 'Project view')
bind('i', 'jk', '<Esc>', 'Escape')
bind('n', '<Leader>Q', '<Cmd>qa!<Cr>', 'Exit neovim')

bind('v', 'J', ":m '>+1<Cr>gv=gv", 'Move selection Down')
bind('v', 'K', ":m '<-2<Cr>gv=gv", 'Move election Up')

bind({ 'n', 'v' }, '<Leader>y', [["+y]], 'Copy to system clipboard')
bind('n', '<Leader>Y', [["+Y]], 'Copy a line to system clipboard')

bind('x', '<Leader>d', [["_dP]], 'Paste yanked text without affecting registers')
bind({ 'n', 'v' }, '<Leader>D', [["_d]], 'Delete selection without affecting registers')

bind('n', 'л', 'gk', 'Cursor Up')
bind('n', 'о', 'gj', 'Cursor Down')
bind('n', 'р', 'h', 'Cursor Left')
bind('n', 'д', 'l', 'Cursor Right')

bind('n', '[c', '<Cmd>lua require("treesitter-context").go_to_context()<Cr>', 'Jumping to context')

bind('n', '<Leader>pf', '<Cmd>Telescope find_files<Cr>', 'Project files')
bind('n', '<c-p>', '<Cmd>Telescope git_files<Cr>', 'Git files')
bind('n', '<Leader>o', '<Cmd>Telescope oldfiles<Cr>', 'Recently opened')
bind('n', '<Leader>b', '<Cmd>Telescope buffers<Cr>', 'Buffer list')
bind('n', '<Leader>h', '<Cmd>Telescope help_tags<Cr>', 'View help')
bind({ 'n', 'v' }, '<Leader>pS', '<Cmd>Telescope grep_string<Cr>', 'Grep search')
bind('n', '<Leader>ps', '<Cmd>Telescope live_grep<Cr>', 'Live search')
bind('n', '<Leader>gk', '<Cmd>Telescope keymaps<Cr>', 'View keymaps')
bind('n', 'z=', '<Cmd>Telescope spell_suggest<Cr>', 'Suggest spellings')

bind('n', '<Leader>G', '<Cmd>Git<Cr>', 'Open git summary window')
bind('n', '<Leader>gp', '<Cmd>Git push<Cr>', 'Execute git push command')

bind('n', '<leader>t', '<Cmd>tabnew<Cr>', 'Create new tab')
bind('n', '<leader>x', '<Cmd>tabclose<Cr>', 'Close tab')
bind('n', '<leader>j', '<Cmd>tabprevious<Cr>', 'Go to previous tab')
bind('n', '<leader>k', '<Cmd>tabnext<Cr>', 'Go to next tab')

bind('n', '<S-Tab>', '<Cmd>bprevious<Cr>', 'Go to previous buffer')
bind('n', '<Tab>', '<Cmd>bnext<Cr>', 'Go to next buffer')
bind('n', '<Leader>B', '<Cmd>bprevious <bar> bdelete #<Cr>', 'Close buffer')

bind('n', '<C-h>', '<C-w>h', 'Move cursor to left window')
bind('n', '<C-l>', '<C-w>l', 'Move cursor to right window')
bind('n', '<C-j>', '<C-w>j', 'Move cursor to bottom window')
bind('n', '<C-k>', '<C-w>k', 'Move cursor to top window')

bind('n', '<Leader>v', '<C-w>v', 'Split current window vertically')
bind('n', '<Leader>s', '<C-w>s', 'Split current window horizontally')
bind('n', '<Leader>q', '<C-w>q', 'Close window')
bind('n', '<Leader>z', '<C-w>z', 'Close preview window')
bind('n', '<Leader>w', '<C-w>w', 'Move cursor between windows')

bind('n', '<Leader>R', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Search and replace')
bind({ 'i', 'n' }, '<Esc>', '<Cmd>noh<Cr><Esc>', 'Clear highlight search')
