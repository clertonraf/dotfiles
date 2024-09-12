return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "<leader>t1", "<cmd>1ToggleTerm<CR>", desc = "Toggle terminal #1" },
		{ "<leader>t2", "<cmd>2ToggleTerm<CR>", desc = "Toggle terminal #2" },
		{ "<leader>t3", "<cmd>3ToggleTerm<CR>", desc = "Toggle terminal #3" },
		{ "<leader>t4", "<cmd>4ToggleTerm<CR>", desc = "Toggle terminal #4" },
		{
			"<leader>t!",
			function()
				_NODE_TOGGLE()
			end,
			desc = "Toggle node",
		},
		{
			"<leader>t@",
			function()
				_RAILS_TOGGLE()
			end,
			desc = "Toggle rails console",
		},
		{
			"<leader>t#",
			function()
				_Ruby_TOGGLE()
			end,
			desc = "Toggle irb (ruby console)",
		},
		{
			"<leader>t$",
			function()
				_DB_TOGGLE()
			end,
			desc = "Toggle rails dbcobsole",
		},
	},
	config = function()
		local toggleterm = require("toggleterm")

		toggleterm.setup({
			size = 10,
			open_mapping = [[\\]],
			--hide_numbers = true,
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = "zsh",
		})

		function _G.set_terminal_keymaps()
			local opts = { noremap = true }
			vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
			-- vim.api.nvim_buf_set_keymap(0, "t", "JK", [[<C-\><C-n>]], opts)
			-- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
			-- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
			-- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
			-- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

		function _LAZYGIT_TOGGLE()
			lazygit:toggle()
		end

		local node = Terminal:new({ cmd = "node", hidden = true })

		function _NODE_TOGGLE()
			node:toggle()
		end

		local dbconsole = Terminal:new({ cmd = "dbconsole", hidden = true })

		function _DB_TOGGLE()
			dbconsole:toggle()
		end

		local rails = Terminal:new({ cmd = "rails c", hidden = true })

		function _RAILS_TOGGLE()
			rails:toggle()
		end

		local ruby = Terminal:new({ cmd = "irb", hidden = true })

		function _Ruby_TOGGLE()
			ruby:toggle()
		end
	end,
}
