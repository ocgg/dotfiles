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

-- Alt-f to format document
map("n", "<A-f>", vim.lsp.buf.format, "Format Document")

-- Diagnostic
map("n", "<leader>dp", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
map("n", "<leader>dn", vim.diagnostic.goto_next, "Go to next diagnostic message")
map("n", "<leader>do", vim.diagnostic.open_float, "Open floating diagnostic message")
map("n", "<leader>dl", vim.diagnostic.setloclist, "Open diagnostics list")

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

-- Search and Replace
map({ "n", "v" }, "<leader>sr", require("ocgg.scripts.search_and_replace").replace, "Search and Replace")
