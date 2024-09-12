return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {},
	config = function(spec, opts)
		require("typescript-tools").setup(opts)

		local augroup = vim.api.nvim_create_augroup("yonvim_typescript_tools", {})
		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			pattern = spec.ft,
			callback = function(args)
				vim.keymap.set("n", "<leader>wi", "<Cmd>TSToolsAddMissingImports<CR>", {
					silent = true,
					desc = "Add missing imports",
					buffer = args.buf,
				})
				vim.keymap.set("n", "<leader>wo", "<Cmd>TSToolsOrganizeImports<CR>", {
					silent = true,
					desc = "Organize imports",
					buffer = args.buf,
				})
				vim.keymap.set("n", "<leader>wu", "<Cmd>TSToolsRemoveUnusedImports<CR>", {
					silent = true,
					desc = "Remove unused imports",
					buffer = args.buf,
				})
				vim.keymap.set("n", "<leader>ws", "<Cmd>TSToolsSortImports<CR>", {
					silent = true,
					desc = "Sort imports",
					buffer = args.buf,
				})
			end,
		})
	end,
	ft = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
}
