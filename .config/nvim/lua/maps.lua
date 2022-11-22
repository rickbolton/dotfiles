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
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)
keymap("n", "<leader>=", "<C-w>=", opts)
keymap("n", "<leader>|", "<C-w>|", opts)
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
keymap("n", "gs", ":Neogit<CR>", opts)

keymap("n", "<C-u>", "<C-u>zz", opts)
keymap("n", "<C-d>", "<C-d>zz", opts)

-- Comment
keymap("n", "<leader>/", comments.call("toggle.linewise.current", "g@$"), { expr = true, silent = true })

-- Move line up/down
keymap("n", "<leader>J", "ddp", opts)
keymap("n", "<leader>K", "ddkP", opts)

keymap("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", opts)
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

keymap("x", "<leader>p", '"_dP')

keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')

keymap("n", "<leader>d", '"_d')
keymap("v", "<leader>d", '"_d')

keymap("v", "<leader>d", '"_d')
