return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },

			-- Close and reopen nvim-tree before saving the session to keep the session file clean
			pre_save_cmds = { "NvimTreeClose" },
			post_restore_cmds = { "NvimTreeOpen" },
		})

		local keymap = vim.keymap

		keymap.set(
			"n",
			"<leader>wr",
			"<cmd>AutoSession restore<CR>",
			{ desc = "Restore session for auto session from cwd" }
		) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
