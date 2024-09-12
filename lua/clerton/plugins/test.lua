return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			log_level = vim.log.levels.DEBUG,
			discovery = { enabled = false },
			diagnostic = {
				enabled = true,
				severity = 1,
			},
			quickfix = {
				open = function()
					if LazyVim.has("trouble.nvim") then
						require("trouble").open({ mode = "quickfix", focus = false })
					else
						vim.cmd("copen")
					end
				end,
			},
			status = {
				enabled = true,
				virtual_text = true,
				signs = true,
			},
			icons = {
				expanded = "",
				child_prefix = "",
				child_indent = "",
				final_child_prefix = "",
				non_collapsible = "",
				collapsed = "",

				passed = "",
				running = "",
				failed = "",
				unknown = "",
			},
			output = {
				enabled = true,
				open_on_run = "short",
			},
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					-- jestConfigFile = "jest.config.js",
					jestConfigFile = function(file)
						if string.find(file, "/packages/") then
							return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
						end

						return vim.fn.getcwd() .. "/jest.config.js"
					end,
					env = { CI = true },
					jest_test_discovery = true,
					cwd = function(file)
						if string.find(file, "/packages/") then
							return string.match(file, "(.-/[^/]+/)src")
						end
						return vim.fn.getcwd()
					end,
					-- cwd = function(_)
					--return vim.fn.getcwd()
					--end,
				}),
			},
		})

		vim.keymap.set("n", "<leader>tO", function()
			neotest.output_panel.toggle()
		end, { desc = "Output test window" })
		vim.keymap.set("n", "<leader>tn", function()
			neotest.run.run()
		end, { desc = "Run nearest test" })
		vim.keymap.set("n", "<leader>td", function()
			neotest.run.run(vim.fn.expand("%"))
		end, { desc = "Run tests in document" })
		vim.keymap.set("n", "<leader>ts", function()
			neotest.run.stop()
		end, { desc = "Stop currently running tests" })
		vim.keymap.set("n", "<leader>tt", function()
			neotest.summary.toggle()
		end, { desc = "Toggle test window" })
		vim.keymap.set("n", "<leader>ta", function()
			neotest.run.run({ suite = true }, { desc = "Run all tests" })
		end)
	end,
}
