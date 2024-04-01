return {
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gfetch', 'Gpush', 'Gclog', 'Gdiffsplit' },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true,
  },
}
