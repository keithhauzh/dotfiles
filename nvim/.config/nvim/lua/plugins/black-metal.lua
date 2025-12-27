return {
  "metalelf0/black-metal-theme-neovim",
  lazy = false,
  priority = 1000,
  config = function()
    require'black-metal'.setup{
			theme = "taake",
			transparent=true,
    }
    require("black-metal").load()
  end,
}
