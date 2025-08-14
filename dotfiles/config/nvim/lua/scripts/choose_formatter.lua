local M = {}

local function fmt(c)
    local b = vim.api.nvim_get_current_buf()
    local before = vim.api.nvim_buf_get_lines(b, 0, -1, false)
    vim.lsp.buf.format({ filter = function(cl) return cl.id == c.id end, async = false })
    local after = vim.api.nvim_buf_get_lines(b, 0, -1, false)
    local hunks = vim.diff(table.concat(before, "\n"), table.concat(after, "\n"), { result_type = "indices" })
    vim.notify(string.format("Formatted with %s (%d changes)", c.name, #hunks), vim.log.levels.INFO)
end

function M.doit()
    local fs = vim.tbl_filter(function(c) return c.server_capabilities.documentFormattingProvider end,
        vim.lsp.get_active_clients({ bufnr = 0 }))
    if #fs == 0 then
        if vim.fn.exists(":Format") == 2 then
            vim.cmd("Format")
            vim.notify("Formatted with fallback (:Format)", vim.log.levels.INFO)
        else
            vim.notify("No LSP or fallback available", vim.log.levels.WARN)
        end
        return
    end
    if #fs == 1 then return fmt(fs[1]) end
    vim.ui.select(fs, { prompt = "Choose LSP to format:", format_item = function(c) return c.name end },
        function(choice) if choice then fmt(choice) end end)
end

return M
