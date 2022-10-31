local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end
local util = require("lspconfig/util")

local function config(_config)
	local bufopts = { noremap = true, silent = true }
	return vim.tbl_deep_extend("force", {
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "gD", vim.lsp.buf.definition, bufopts)
			-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)
			vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, bufopts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_next, bufopts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, bufopts)
			vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

			if client.name == "tsserver" then
				client.resolved_capabilities.document_formatting = false
			end
			if client.name ~= "sumneko_lua" and client.server_capabilities.documentFormattingProvider then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("Format", { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format()
					end,
				})
			end
		end,
	}, _config or {})
end

nvim_lsp.sumneko_lua.setup(config({
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}))

nvim_lsp.tsserver.setup(config({ filetypes = { "typescript", "typescriptreact", "typescript.tsx" } }))

nvim_lsp.vuels.setup(config({ root_dir = util.root_pattern("nuxt.config.js", "package.json") }))

nvim_lsp.tailwindcss.setup(config())

nvim_lsp.intelephense.setup(config({ init_options = { licenceKey = "00R7CVDYEXOB400" } }))

require("lspconfig").svelte.setup(config())

require("lspconfig").cssls.setup(config())

require("lspconfig").gopls.setup(config({
	cmd = { "gopls", "serve" },
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}))

require("lspconfig").rust_analyzer.setup(config({
	-- cmd = { "rustup", "run", "nightly", "rust-analyzer" },
	settings = {
		["rust-analyzer"] = {},
	},
}))

require("lspconfig").prismals.setup(config())
