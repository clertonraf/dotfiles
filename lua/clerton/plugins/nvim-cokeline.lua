return {
	"willothy/nvim-cokeline",
	dependencies = {
		"nvim-lua/plenary.nvim", -- Required for v0.4.0+
		"nvim-tree/nvim-web-devicons", -- If you want devicons
		"stevearc/resession.nvim", -- Optional, for persistent history
	},
	config = function()
		local map = vim.api.nvim_set_keymap

		map("n", "<S-Tab>", "<Plug>(cokeline-focus-prev)", { silent = true })
		map("n", "<Tab>", "<Plug>(cokeline-focus-next)", { silent = true })
		map("n", "<Leader>p", "<Plug>(cokeline-switch-prev)", { silent = true })
		map("n", "<Leader>n", "<Plug>(cokeline-switch-next)", { silent = true })

		for i = 1, 9 do
			map("n", ("<F%s>"):format(i), ("<Plug>(cokeline-focus-%s)"):format(i), { silent = true })
			map("n", ("<Leader>%s"):format(i), ("<Plug>(cokeline-switch-%s)"):format(i), { silent = true })
		end
	end,
}
