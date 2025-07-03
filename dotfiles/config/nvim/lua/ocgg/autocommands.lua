-- :nohl after a search AND after the cursor moves
-- from reddit (https://www.reddit.com/r/neovim/comments/1ct2w2h/lua_adaptation_of_vimcool_auto_nohlsearch/)
vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
            vim.schedule(function()
                vim.cmd.nohlsearch()
            end)
        end
    end,
    group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
})

-- Highlight on yank (from kickstart)
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    pattern = "*",
})

-- set wrap on markdown & text files
vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        local ftype = vim.bo.filetype
        if ftype == "markdown"
            or ftype == "text"
        then
            vim.wo.wrap = true
        end
        if ftype == "ruby"
            or ftype == "css"
            or ftype == "eruby"
            or ftype == "javascript"
            or ftype == "slim"
            or ftype == "markdown"
        then
            vim.bo.tabstop = 2
            vim.bo.shiftwidth = 2
        end
    end,
    group = vim.api.nvim_create_augroup("TabStopAndShiftWidth", { clear = true }),
    pattern = "*",
})
