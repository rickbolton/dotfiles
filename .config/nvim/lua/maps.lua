local status, comments = pcall(require, "Comment.api")
if not status then
	return
end

local keymap = vim.keymap.set

-- Silent keymap option
local opts = { silent = true }

keymap("n", "ss", ":vsplit<CR>", opts)
keymap("n", "sf", ":split<CR>", opts)
keymap("n", "tn", ":tabnew<CR>", opts)
keymap("n", "tl", ":tabnext<CR>", opts)
keymap("n", "th", ":tabprev<CR>", opts)
keymap("n", "<Leader>h", "<C-w>h", opts)
keymap("n", "<Leader>j", "<C-w>j", opts)
keymap("n", "<Leader>k", "<C-w>k", opts)
keymap("n", "<Leader>l", "<C-w>l", opts)
keymap("n", "<Leader>=", "<C-w>=", opts)
keymap("n", "<Leader>|", "<C-w>|", opts)
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
keymap("n", "gs", ":Neogit<CR>", opts)

keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Comment
keymap("n", "<leader>/", comments.call("toggle.linewise.current", "g@$"), { expr = true, silent = true })

-- Move line up/down
keymap("n", "<leader>J", "ddp", opts)
keymap("n", "<leader>K", "ddkP", opts)
