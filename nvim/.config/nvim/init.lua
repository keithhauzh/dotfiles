-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- KEYBINDS
vim.o.termguicolors = true
vim.cmd([[set noswapfile]])
-- vim.cmd("colorscheme blue")
vim.o.guicursor = ""
vim.o.tabstop = 2
vim.o.winborder = "rounded"
-- vim.o.winborder = "none"
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.wrap = false
-- vim.o.cursorcolumn = true
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartindent = true
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true

vim.g.mapleader = " "
local map = vim.keymap.set
map({ "n" }, "<leader>w", "<Cmd>update<CR>", { desc = "Write the current buffer." })
map({ "n" }, "<leader>W", "<Cmd>update<CR>", { desc = "Write all buffers." })
map({ "n" }, "<leader>q", "<Cmd>:quit<CR>", { desc = "Quit the current buffer." })
map({ "n" }, "<leader>Q", "<Cmd>:wqa<CR>", { desc = "Quit all buffers and write." })
map({ "n", "x" }, "<leader>y", '"+y')

-- LSP KEYBINDS
map({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })
map("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
map("v", "<leader>bf", vim.lsp.buf.references, { desc = "References" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "<leader>D", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { desc = "Fill up quick fix list with LSP diagnostics" })
-- Setup lazy.nvim
require("lazy").setup({
	spec = {

		-- COLORSCHEMES
		{
			"metalelf0/black-metal-theme-neovim",
			lazy = false,
			priority = 1000,
			config = function()
				require 'black-metal'.setup {
					-- theme = "bathory",
					-- theme = "windir",
					-- theme = "dark-funeral",
					theme = "khold",
					-- plain_float = true,
					-- cursorline_gutter = true,
					highlights = {
						-- Without this, cursorline is invisible
						["CursorLine"] = { bg = "#1f1f1f" }, -- pick a visible background color
					},
				}
				require("black-metal").load()
			end,
		},
		{
			"rose-pine/neovim",
			name = "rose-pine",
			-- config = function()
			-- 	vim.cmd("colorscheme rose-pine")
			-- end,
		},
		{
			'saghen/blink.cmp',
			-- optional: provides snippets for the snippet source
			dependencies = { 'rafamadriz/friendly-snippets' },

			-- use a release tag to download pre-built binaries
			version = '1.*',
			-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
			-- build = 'cargo build --release',
			-- If you use nix, you can build from source using latest nightly rust with:
			-- build = 'nix run .#build-plugin',

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
				-- 'super-tab' for mappings similar to vscode (tab to accept)
				-- 'enter' for enter to accept
				-- 'none' for no mappings
				--
				-- All presets have the following mappings:
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)
				--
				-- See :h blink-cmp-config-keymap for defining your own keymap
				keymap = { preset = 'default' },

				appearance = {
					-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
					-- Adjusts spacing to ensure icons are aligned
					nerd_font_variant = 'mono'
				},

				-- (Default) Only show the documentation popup when manually triggered
				completion = { documentation = { auto_show = false } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { 'lsp', 'path', 'snippets', 'buffer' },
				},

				-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
				-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
				-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
				--
				-- See the fuzzy documentation for more information
				fuzzy = { implementation = "prefer_rust_with_warning" }
			},
			opts_extend = { "sources.default" }
		},
		{
			'akinsho/bufferline.nvim',
			version = "*",
			dependencies = 'nvim-tree/nvim-web-devicons',
			config = function()
				require 'bufferline'.setup()
			end,
			opts = {}
		},
		{
			'nvim-lualine/lualine.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons' },
			config = function()
				require 'lualine'.setup()
			end,
		},
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons", -- optional, but recommended
			},
			config = function()
				map("n", "<leader>t", "<Cmd>:Neotree filesystem reveal right<CR>")
			end,
			lazy = false, -- neo-tree will lazily load itself		
		},
		{
			"https://github.com/norcalli/nvim-colorizer.lua",
			opts = {},
			config = function()
				vim.o.termguicolors = true
			end
		},
		{
			'nvim-flutter/flutter-tools.nvim',
			lazy = false,
			dependencies = {
				'nvim-lua/plenary.nvim',
				'stevearc/dressing.nvim', -- optional for vim.ui.select
			},
			config = function()
				require 'flutter-tools'.setup {
					flutter_path = vim.env.FLUTTER_SDK .. '/bin/cache/dart-sdk/bin/dart'
				}
			end
		},
		{
			"https://github.com/neovim/nvim-lspconfig"
		},
		{
			"https://github.com/mason-org/mason-lspconfig.nvim",
			config = function()
				require("mason-lspconfig").setup({
					ensure_installed = {
						"cssls",
						"lua_ls",
						"emmet_language_server",
						"emmet_ls",
						"jsonls",
						"svelte",
						"tailwindcss",
						"taplo",
						"ts_ls"
					}
				})
			end
		},
		{
			"https://github.com/mason-org/mason.nvim",
			config = function()
				require("mason").setup()
			end
		},
		{
			'stevearc/oil.nvim',
			opts = {
				default_file_explorer = false,
				delete_to_trash = true,
				view_options = {
					show_hidden = true
				}
			},
			dependencies = { { "nvim-mini/mini.icons", opts = {} } },
			lazy = false,
			config = function()
				require 'oil'.setup()
				vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
			end
		},
		{
			'nvim-telescope/telescope.nvim',
			tag = 'v0.2.0',
			dependencies = { 'nvim-lua/plenary.nvim' },
			config = function()
				require 'telescope'.setup({
					defaults = {
						file_ignore_patterns = { "node_modules" }
					}
				})
				local builtin = require('telescope.builtin')
				vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
				vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
				vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
				vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
			end
		},
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			build = ':TSUpdate',
		},
		{
			"nvim-tree/nvim-web-devicons", opts = {}
		},
		{
			"mikavilpas/yazi.nvim",
			version = "*", -- use the latest stable version
			event = "VeryLazy",
			dependencies = {
				{ "nvim-lua/plenary.nvim", lazy = true },
			},
			keys = {
				-- 👇 in this section, choose your own keymappings!
				{
					"<leader>e",
					mode = { "n", "v" },
					"<cmd>Yazi<cr>",
					desc = "Open yazi at the current file",
				},
				{
					-- Open in the current working directory
					"<leader>ce",
					"<cmd>Yazi cwd<cr>",
					desc = "Open the file manager in nvim's working directory",
				},
				{
					"<c-up>",
					"<cmd>Yazi toggle<cr>",
					desc = "Resume the last yazi session",
				},
			},
			---@type YaziConfig | {}
			opts = {
				-- if you want to open yazi instead of netrw, see below for more info
				open_for_directories = false,
				keymaps = {
					show_help = "<f1>",
				},
			},
			-- 👇 if you use `open_for_directories=true`, this is recommended
			init = function()
				-- mark netrw as loaded so it's not loaded at all.
				--
				-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
				vim.g.loaded_netrwPlugin = 1
			end,
		}
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "blue" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
