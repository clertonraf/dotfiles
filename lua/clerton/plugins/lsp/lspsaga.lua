return {
	"nvimdev/lspsaga.nvim",
	event = { "LspAttach" },
	config = function()
		require("lspsaga").setup({
			code_action = {
				show_server_name = true,
			},
		})
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- optional
		"nvim-tree/nvim-web-devicons", -- optional
	},
}
