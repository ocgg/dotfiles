vim.g.mapleader = " "

local function map(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc or rhs })
end

map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", "Toggle NvimTree")

-- Exit insert mode
map("i", "jk", "<ESC>")

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

-- Alt+j/k to move 5 lines up/down
map("n", "<A-j>", "5jzz", "Move 5 lines down")
map("n", "<A-k>", "5kzz", "Move 5 lines up")

-- Alt+h/l to move 10 characters left/right
map("n", "<A-h>", "10h", "Move 10 characters left")
map("n", "<A-l>", "10l", "Move 10 characters right")

-- Alt+Shift+J/K to move lines or blocks (in visual line mode)
map("x", "<A-J>", ":m '>+1<CR>gv=gv", "Move line/block down")
map("x", "<A-K>", ":m '<-2<CR>gv=gv", "Move line/block up")
map("n", "<A-J>", ":m .+1<CR>==", "Move line down")
map("n", "<A-K>", ":m .-2<CR>==", "Move line up")

-- Search and Replace
map({ "n", "v" }, "<leader>sr", require("ocgg.scripts.search_and_replace").replace, "Search and Replace")
