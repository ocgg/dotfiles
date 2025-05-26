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
                jump_prev = '[[',
                jump_next = ']]',
                accept = '<A-m>',
                refresh = 'gr',
                open = '<M-CR>',
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
                accept = '<A-m>',
                accept_word = '<A-$>',
                accept_line = false,
                next = '<A-*>',
                prev = '<A-ù>',
                dismiss = '<A-w>',
            },
        },
    }
}
