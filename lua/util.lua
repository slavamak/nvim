local M = {}

M.bind = function(opts)
  return function(mode, keys, callback, descOrOpts)
    local options = {}

    if type(opts) == 'table' then
      for k, v in pairs(opts) do
        options[k] = v
      end
    end

    if type(descOrOpts) == 'table' then
      for k, v in pairs(descOrOpts) do
        options[k] = v
      end
    else
      options.desc = descOrOpts
    end

    vim.keymap.set(mode, keys, callback, options)
  end
end

M.toggle_netrw = function()
  if vim.g.netrw_is_open == 1 then
    for i = 1, vim.fn.bufnr '$' do
      if vim.fn.getbufvar(i, '&filetype') == 'netrw' then vim.cmd('bdelete ' .. i) end
    end
    vim.g.netrw_is_open = 0
  else
    vim.g.netrw_is_open = 1
    vim.cmd 'Explore'
  end
end

-- Returns true for files larger than 100KB or for minified files.
M.is_large_or_minified = function(buf)
  local max_filesize = 100 * 1024
  local line_count = vim.api.nvim_buf_line_count(buf)
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

  if ok and stats then
    if stats.size > max_filesize or (stats.size > 1024 and line_count == 1) then return true end
  end

  return false
end

M.augroup = function(name)
  return vim.api.nvim_create_augroup('augroup_' .. name, { clear = true })
end

return M
