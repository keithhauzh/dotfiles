return {
	"https://github.com/mason-org/mason-lspconfig.nvim",
	config = function()
		require 'mason-lspconfig'.setup {
			ensure_installed = { "cssls",
				"lua_ls",
				"emmet_language_server",
				"emmet_ls",
				"jsonls",
				"svelte",
				"tailwindcss",
				"taplo",
				"ts_ls"
			}
		}
	end
}
