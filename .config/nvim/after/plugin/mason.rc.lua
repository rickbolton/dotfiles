local status, mason = pcall(require, "mason")
if not status then
	return
end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
	return
end

mason.setup({})

lspconfig.setup({
	ensure_installed = {
		-- lua stuff
		"lua-language-server",
		"stylua",
		"sumneko_lua",

		-- web dev
		"css-lsp",
		"html-lsp",
		"typescript-language-server",
		"vue-language-server",
		"deno",
		"emmet-ls",
		"json-lsp",
		"tailwindcss-language-server",
		"prettier",
		"prettierd",
		"eslint_d",
		"eslint-lsp",
		"tailwindcss",
		"prisma-language-server",

		-- rust
		"rust-analyzer",
		"taplo",

		-- shell
		"shfmt",
		"shellcheck",
	},
})
