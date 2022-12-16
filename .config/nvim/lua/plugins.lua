local status, packer = pcall(require, "packer")
if not status then
	print("Packer is not installed")
	return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
	use("wbthomason/packer.nvim")
	use("nvim-lualine/lualine.nvim") -- Statusline
	use("arkav/lualine-lsp-progress")
	use("nvim-lua/plenary.nvim") -- Common utilities
	use("onsails/lspkind-nvim") -- vscode-like pictogramsplugins
	use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua
	use("MunifTanjim/prettier.nvim") -- Prettier plugin for Neovim's built-in LSP client
	use("gruvbox-community/gruvbox")
	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use("windwp/nvim-autopairs")

	use("folke/tokyonight.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })

	use("L3MON4D3/LuaSnip")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use({
		"kyazdani42/nvim-tree.lua",
		requires = {
			"kyazdani42/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
	})
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")
	use("windwp/nvim-ts-autotag")
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use("akinsho/nvim-bufferline.lua")

	use("lewis6991/gitsigns.nvim")
	use("dinhhuy258/git.nvim") -- For git blame & browse
	use({
		"numToStr/Comment.nvim",
		config = function()
			local numStatus, comments = pcall(require, "Comment")
			if not numStatus then
				return
			end

			comments.setup()
		end,
	})

	use("simrat39/rust-tools.nvim")
	-- Debugging
	use("mfussenegger/nvim-dap")

	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Copilot
	use("github/copilot.vim")
end)
