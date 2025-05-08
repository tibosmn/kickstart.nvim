-- Git diffview
return {
  'sindrets/diffview.nvim',
  config = function()
    vim.keymap.set('n', '<leader>gv', function()
      local view = require('diffview.lib').get_current_view()
      if view then
        -- If Diffview is open, close it
        vim.cmd 'DiffviewClose'
      else
        -- Otherwise, open it
        vim.cmd 'DiffviewOpen'
      end
    end, { desc = 'git diff [v]iew toggle' })
  end,
}

