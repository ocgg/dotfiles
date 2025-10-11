return {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    opts = {
        server_opts_overrides = {
            settings = {
                telemetry = {
                    telemetryLevel = "off",
                },
            },
        },
        panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
                jump_prev = '<C-p>',
                jump_next = '<C-n>',
                accept = '<CR>',
                refresh = '<A-r>',
                open = '<A-CR>',
            },
            layout = {
                position = 'right', -- bottom | top | left | right
                ratio = 0.4,
            },
        },
        suggestion = {
            enabled = true,
            auto_trigger = false,
            hide_during_completion = true,
            debounce = 200,
            keymap = {
                accept = '<A-l>', -- will trigger suggestion
                accept_word = '<A-$>',
                accept_line = '<A-j>',
                next = '<A-n>',
                prev = '<A-p>',
                dismiss = '<A-w>',
            },
        },
    }
}
