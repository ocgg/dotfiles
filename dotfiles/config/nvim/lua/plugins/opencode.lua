return {
  "NickvanDyke/opencode.nvim",
  dependencies = {
    ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
    { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`
    }

    -- Required for `opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<leader>oa", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask about this" })
    vim.keymap.set({ "n", "x" }, "<leader>o+", function() require("opencode").prompt("@this") end, { desc = "Add this" })
    vim.keymap.set({ "n", "x" }, "<leader>oe", function() require("opencode").prompt("Explain @this and its context", { submit = true }) end, { desc = "Explain this" })
    vim.keymap.set({ "n", "x" }, "<leader>os", function() require("opencode").select() end, { desc = "Opencode actions..." })
    vim.keymap.set("n", "<leader>oo", function() require("opencode").toggle() end, { desc = "Toggle Opencode" })
    vim.keymap.set("n", "<leader>on", function() require("opencode").command("session_new") end, { desc = "New session" })
    vim.keymap.set("n", "<leader>oi", function() require("opencode").command("session_interrupt") end, { desc = "Interrupt session" })
    vim.keymap.set("n", "<S-C-u>",    function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" })
    vim.keymap.set("n", "<S-C-d>",    function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" })
  end,
}
