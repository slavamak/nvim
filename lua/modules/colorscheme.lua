local M = {}

M.variants = {
  light = {
    none = 'NONE',
    bg = 'NvimLightGrey1',
    fg = 'NvimDarkGrey2',
    muted = 'NvimLightGrey3',
    subtle = 'NvimDarkGrey4',
    overlay = 'NvimLightGrey2',
    blue = 'NvimDarkBlue',
    cyan = 'NvimDarkCyan',
    green = 'NvimDarkGreen',
    magenta = 'NvimDarkMagenta',
    red = 'NvimDarkRed',
    yellow = 'NvimDarkYellow',
  },
  dark = {
    none = 'NONE',
    bg = 'NvimDarkGrey2',
    fg = 'NvimLightGrey2',
    muted = 'NvimDarkGrey3',
    subtle = 'NvimLightGrey4',
    overlay = 'NvimDarkGrey2',
    blue = 'NvimDarkBlue',
    cyan = 'NvimDarkCyan',
    green = 'NvimDarkGreen',
    magenta = 'NvimDarkMagenta',
    red = 'NvimDarkRed',
    yellow = 'NvimDarkYellow',
  },
}

M.current_palette = function()
  return M.variants[vim.o.background]
end

function M.set_highlights()
  local palette = M.current_palette()

  -- vim.api.nvim_set_hl(0, 'Normal', { fg = palette.fg, bg = palette.bg })
  vim.api.nvim_set_hl(0, 'StatusLine', { fg = palette.subtle, bg = palette.none })
  vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = palette.muted, bg = palette.none })
  vim.api.nvim_set_hl(0, 'NonText', { fg = palette.muted })
end

return M
