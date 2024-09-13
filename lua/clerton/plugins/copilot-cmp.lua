return {
	"zbirenbaum/copilot-cmp",
	dependencies = "copilot.lua",
	event = { "InsertEnter", "LspAttach" },
	fix_pairs = true,
	opts = {},
	config = function(_, opts)
		local copilot_cmp = require("copilot_cmp")
		copilot_cmp.setup(opts)
	end,
}
