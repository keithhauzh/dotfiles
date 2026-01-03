return {
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
}
