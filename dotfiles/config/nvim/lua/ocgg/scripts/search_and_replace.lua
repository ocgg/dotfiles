local M = {}

local function wrong_mode_msg()
	local msg = "Must be in normal, visual char or visual line mode"
	vim.notify(msg, vim.log.levels.ERROR)
end

--[[ "Sanitize" the pattern to be used with the substitute command,
by escaping newlines, removing end of line and escaping slashes.
]]
local function escape_unwanted_chars(str)
	str = vim.fn.escape(str, [[/\]])
	str = str
		:gsub("\n", [[\n]]) -- newlines (behave strangely w/o this)
		:gsub("\\n$", "") -- trailing newline
	-- use "very nomagic" mode with \V (ignore most regex special chars)
	return "\\V" .. str
end

--[[ Returns visual selection with escaped chars
]]
local function get_visual_selection()
	-- the vim register to use
	local reg = "0"
	-- saves register content to recover it later
	local prev_content = vim.fn.getreg(reg)
	-- save visual selection in register
	vim.cmd.normal('"' .. reg .. "y")
	local pattern = escape_unwanted_chars(vim.fn.getreg(reg))
	-- restore register content
	vim.fn.setreg(reg, prev_content)
	return pattern
end

--[[ Prepare substitute command to replace the visual selection if any, or
the word under the cursor.
]]
function M.replace()
	local mode = vim.api.nvim_get_mode().mode
	local v_or_V = mode == "v" or mode == "V"

	-- should only work in n, v or v-line modes
	if mode ~= "n" and not v_or_V then
		wrong_mode_msg()
		return
	end

	-- use either visual selection or current word
	local pattern = v_or_V and get_visual_selection() or vim.fn.expand("<cword>")
	-- type the substitution command & place the cursor
	-- TODO: IGNORE KEYCODES LIKE <CR> OR <ESC> (test this line)
	vim.api.nvim_input("<Esc>:%s/\\(" .. pattern .. "\\)//g<left><left>")
end

return M
