return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		-- "rishabhjain9191/telescope-monorepos",
		"sato-s/telescope-rails.nvim",
		"LukasPietzschmann/telescope-tabs",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local transform_mod = require("telescope.actions.mt").transform_mod

		local trouble = require("trouble")
		local trouble_telescope = require("trouble.sources.telescope")

		-- or create your custom action
		local custom_actions = transform_mod({
			open_trouble_qflist = function()
				trouble.toggle("quickfix")
			end,
		})

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
						["<C-t>"] = trouble_telescope.open,
					},
				},
			},
		})

		telescope.load_extension("fzf")
		-- telescope.load_extension("monorepos")
		telescope.load_extension("telescope-tabs")
		telescope.load_extension("rails")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>rc", "<Cmd>Telescope rails controllers<CR>", { desc = "Find Rails Controllers" })
		keymap.set("n", "<leader>rm", "<Cmd>Telescope rails models<CR>", { desc = "Find Rails Models" })
		keymap.set("n", "<leader>ri", "<Cmd>Telescope rails migrations<CR>", { desc = "Find Rails Migrations" })
		keymap.set("n", "<leader>rv", "<Cmd>Telescope rails views<CR>", { desc = "Find Rails Views" })
		keymap.set("n", "<leader>rt", "<Cmd>Telescope rails specs<CR>", { desc = "Find RSpec tests" })
		--keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		-- keymap.set("n", "<leader>fm", "<cmd>Telescope monorepos<cr>", { desc = "Find folder on mono repository" })
		-- keymap.set("n", "<leader>ft", "<cmd>Telescope telescope-tabs list_tabs<cr>", { desc = "List open tabs" })
	end,
}
