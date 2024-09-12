return {
	"https://github.com/Weyaaron/nvim-training",
	pin = true,
	opts = {
		audio_feedback = true, -- Enables/Disables audio feedback, if enabled, requires the 'sox' package providing the 'play' command.
		base_path = vim.fn.stdpath("data") .. "/nvim-training/",
		counter_bounds = { 1, 5 },
		custom_collections = {}, -- A table of tables containing names of tasks, for details read on.
		enable_counters = true, -- Enables/Disables counters in tasks that support counters.
		enable_events = true, -- If the plugin should save events. These are used for the subcommand analyze.
		possible_marks_list = { "a", "b", "c", "r", "s", "t", "d", "n", "e" }, -- A list of possible marks.
		possible_register_list = { "a", "b", "c", "r", "s", "t", "d", "n", "e" }, -- A list of possible registers.
		task_alphabet = "ABCDEFGabddefg,.",
	},
}
