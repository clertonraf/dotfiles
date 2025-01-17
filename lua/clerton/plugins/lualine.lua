return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	optional = true,
	event = "VeryLazy",
	opts = function(_, opts)
		local colors = {
			[""] = LazyVim.ui.fg("Special"),
			["Normal"] = LazyVim.ui.fg("Special"),
			["Warning"] = LazyVim.ui.fg("DiagnosticError"),
			["InProgress"] = LazyVim.ui.fg("DiagnosticWarn"),
		}
		table.insert(opts.sections.lualine_x, 2, {
			function()
				local icon = LazyVim.config.icons.kinds.Copilot
				local status = require("copilot.api").status.data
				return icon .. (status.message or "")
			end,
			cond = function()
				if not package.loaded["copilot"] then
					return
				end
				local ok, clients = pcall(LazyVim.lsp.get_clients, { name = "copilot", bufnr = 0 })
				if not ok then
					return false
				end
				return ok and #clients > 0
			end,
			color = function()
				if not package.loaded["copilot"] then
					return
				end
				local status = require("copilot.api").status.data
				return colors[status.status] or colors[""]
			end,
		})
	end,
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
			},
			sections = {
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})
	end,
}
