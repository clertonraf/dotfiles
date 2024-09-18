return {
	"sotte/presenting.nvim",
	opts = {
		options = {
			-- The width of the slide buffer.
			width = math.ceil(vim.api.nvim_win_get_width(0) * 0.75),
		},
		-- fill in your options here
		-- see :help Presenting.config
	},
	cmd = { "Presenting" },
}
