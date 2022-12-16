local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	"html",
	"cssls",
	"tsserver",
	"gopls",
	"prismals",
	"svelte",
	"sumneko_lua",
	"rust_analyzer",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-b>"] = cmp.mapping.scroll_docs(-4),
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.abort(),
	["<CR>"] = cmp.mapping.confirm(cmp_select),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings["<Tab>"] = nil
cmp_mappings["<S-Tab>"] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.on_attach(function(client, bufnr)
	local noremap = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set

	bind("n", "gD", vim.lsp.buf.definition, noremap)
	bind("n", "K", vim.lsp.buf.hover, noremap)
	bind("n", "<leader>vws", vim.lsp.buf.workspace_symbol, noremap)
	bind("n", "<leader>vd", vim.diagnostic.open_float, noremap)
	bind("n", "[d", vim.diagnostic.goto_next, noremap)
	bind("n", "]d", vim.diagnostic.goto_prev, noremap)
	bind("n", "<leader>vca", vim.lsp.buf.code_action, noremap)
	bind("n", "<leader>vrr", vim.lsp.buf.references, noremap)
	bind("n", "<leader>vrn", vim.lsp.buf.rename, noremap)
	bind("i", "<C-h>", vim.lsp.buf.signature_help, noremap)

	if client.name == "tsserver" then
		client.server_capabilities.document_formatting = false
	end

	if client.name ~= "sumneko_lua" and client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				local buf = vim.lsp.buf
				buf.format()
			end,
		})
	end
end)

lsp.nvim_workspace()

local rust_lsp = lsp.build_options("rust_analyzer", {})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

-- Initialize rust_analyzer with rust-tools
require("rust-tools").setup({ server = rust_lsp })
