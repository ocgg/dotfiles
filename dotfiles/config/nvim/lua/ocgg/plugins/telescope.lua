return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    require('telescope').setup {}
    require('telescope').load_extension 'fzf'
    -- set keymaps
    local keymap = vim.keymap
    local builtin = require 'telescope.builtin'

    -- [f]ind keymaps
    keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Find string under cursor in cwd' })
    keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy find string in current buffer' })

    -- [goto] keymaps
    keymap.set('n', '<leader>gd', builtin.lsp_definitions, { desc = '[G]oto [d]efinition' })
    keymap.set('n', '<leader>gr', builtin.lsp_references, { desc = '[G]oto [r]eferences' })
    keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = '[G]oto [i]mplementation' })
    keymap.set('n', '<leader>gD', builtin.lsp_type_definitions, { desc = 'Type [D]efinition' })
    keymap.set('n', '<leader>gs', builtin.lsp_document_symbols, { desc = 'Document [s]ymbols' })
    keymap.set('n', '<leader>gS', builtin.lsp_document_symbols, { desc = 'Workspace [S]ymbols' })

    -- diagnostics keymaps
    keymap.set('n', '<leader>dd', builtin.diagnostics, { desc = 'Telescope Project [d]iagnostics' })
  end,
}
