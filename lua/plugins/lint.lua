return {

  { -- Linting
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'
      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      lint.linters_by_ft = lint.linters_by_ft or {}
      --lint.linters_by_ft['markdown'] = { 'markdownlint' }
      lint.linters_by_ft['python'] = { 'flake8' }
      lint.linters_by_ft['lua'] = { 'luacheck' }
      lint.linters_by_ft['typescript'] = { 'eslint_d' }
      lint.linters_by_ft['javascript'] = { 'eslint_d' }

      -- Override flake8 config to disable E501 (line too long), is handled by formatting with black
      lint.linters.flake8 = {
        cmd = 'flake8',
        stdin = true,
        args = { '--ignore=E501', '-' },
      }

      -- Create autocommand which carries out the actual linting
      -- on the specified events.
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          -- Only run the linter in buffers that you can modify in order to
          -- avoid superfluous noise, notably within the handy LSP pop-ups that
          -- describe the hovered symbol using Markdown.
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
