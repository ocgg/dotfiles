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
                jump_prev = '<A-*>',
                jump_next = '<A-ù>',
                accept = '<A-l>',
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
                accept = '<A-l>',
                accept_word = '<A-$>',
                accept_line = false,
                next = '<A-*>', -- will trigger suggestion
                prev = '<A-ù>',
                dismiss = '<A-w>',
            },
        },
    }
}
