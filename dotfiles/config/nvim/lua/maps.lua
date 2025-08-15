vim.g.mapleader = " "

local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc or rhs })
end

map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree")

-- Resize Windows
map("n", "<C-Left>", "<C-w><")
map("n", "<C-Right>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- LSP
map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

-- Diagnostic
map("n", "<leader>dp", vim.diagnostic.goto_prev, "vim.diagnostic.goto_prev")
map("n", "<leader>dn", vim.diagnostic.goto_next, "vim.diagnostic.goto_next")
map("n", "<leader>do", vim.diagnostic.open_float, "vim.diagnostic.open_float")
map("n", "<leader>dl", vim.diagnostic.setloclist, "diagnostics list: vim.diagnostic.setloclist")

map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
map("n", "<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

-- for visual line reindent
map("v", "<", "<gv")
map("v", ">", ">gv")

-- INSERT MODE NAVIGATION
map("i", "<A-j>", "<Down>", "Move down")
map("i", "<A-k>", "<Up>", "Move up")
map("i", "<A-h>", "<Left>", "Move left")
map("i", "<A-l>", "<Right>", "Move right")

-- NORMAL MODE NAVIGATION
map("n", "<A-j>", "5jzz", "Move 5 lines down")
map("n", "<A-k>", "5kzz", "Move 5 lines up")
map("n", "<A-h>", "10h", "Move 10 characters left")
map("n", "<A-l>", "10l", "Move 10 characters right")

-- Alt+Shift+J/K to move lines or blocks (in visual line mode)
map("x", "<A-J>", ":m '>+1<CR>gv=gv", "Move line/block down")
map("x", "<A-K>", ":m '<-2<CR>gv=gv", "Move line/block up")
map("n", "<A-J>", ":m .+1<CR>==", "Move line down")
map("n", "<A-K>", ":m .-2<CR>==", "Move line up")

-- Alt+Shift+number for tab selection
-- map("n", "<A-1>", "1gt", "Go to tab 1")
-- map("n", "<C-A>2", "2gt", "Go to tab 2")
-- map("n", "<C-A>3", "3gt", "Go to tab 3")
-- map("n", "<C-A>4", "4gt", "Go to tab 4")
-- map("n", "<C-A>5", "5gt", "Go to tab 5")

map("i", ":w<CR>", "<Esc>:w<CR>", "Save on :w insert mode")
map("i", ":wa<CR>", "<Esc>:wa<CR>", "Save on :w insert mode")

-- Search and Replace
map({ "n", "v" }, "<leader>sr", require("scripts.search_and_replace").replace, "Search and Replace")

-- Format document & choose formatter if several available
map("n", "<A-f>", require("scripts.choose_formatter").doit, "Format Document")

local function toggle_kanagawa_theme()
    local current = vim.g.kanagawa_theme
    local next = (current == "wave" or not current) and "dragon" or "wave"
    vim.g.kanagawa_theme = next
    vim.cmd("colorscheme kanagawa-" .. next)
end

vim.keymap.set('n', '<leader>*t', toggle_kanagawa_theme, { desc = "[C]hange [T]heme (kanagawa wave/dragon)" })

vim.keymap.set("n", "<A-z>", function()
  vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle wrap" })
