return {
  'nvim-telescope/telescope-project.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('telescope').setup {
      extensions = {
        project = {
          base_dirs = {
            { '~/Documents/projects/', max_depth = 3 },
          },
          on_project_selected = function(prompt_bufnr)
            -- Do anything you want in here. For example:
            project_actions.change_working_directory(prompt_bufnr, false)
          end,
        },
      },
    }

    require('telescope').load_extension 'project'

    -- Optional: Keymap to open the project list
    vim.keymap.set('n', '<leader>p', function()
      require('telescope').extensions.project.project()
    end, { desc = 'Telescope: open projects' })
  end,
}
