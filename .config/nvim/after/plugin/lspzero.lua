local lsp = require("lsp-zero")
local cmp = require("cmp")

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

lsp.on_attach(function(client, bufnr)
	local noremap = { buffer = bufnr, remap = false }
	local bind = vim.keymap.set
	local rt = require("rust-tools")

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

--[[ lsp.setup_nvim_cmp({
	snippet = {},
	sources = {
		{ name = "copilot" },

		{ name = "path" },
		{ name = "nvim_lsp", keyword_length = 3 },
		{ name = "buffer", keyword_length = 3 },
		{ name = "luasnip", keyword_length = 2 },
	},
	mapping = lsp.defaults.cmp_mappings({
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
	}),
}) ]]

local rust_lsp = lsp.build_options("rust_analyzer", {})

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

-- Initialize rust_analyzer with rust-tools
require("rust-tools").setup({ server = rust_lsp })
