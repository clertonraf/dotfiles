return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local VIEW_WIDTH_FIXED = 35
		local view_width_max = VIEW_WIDTH_FIXED -- fixed to start

		-- toggle the width and redraw
		local function toggle_width_adaptive()
			if view_width_max == -1 then
				view_width_max = VIEW_WIDTH_FIXED
			else
				view_width_max = -1
			end

			require("nvim-tree.api").tree.reload()
		end

		local function get_view_width_max()
			return view_width_max
		end

		nvimtree.setup({
			view = {
				width = {
					min = 35,
					max = get_view_width_max(),
				},
				relativenumber = true,
			},
			-- change folder arrows icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		keymap.set("n", "A", toggle_width_adaptive, { desc = "Toggle Adaptive Width" })
	end,
}
