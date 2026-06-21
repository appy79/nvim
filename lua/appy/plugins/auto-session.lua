return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_restore_enabled = true,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },

			-- Close and reopen nvim-tree before saving the session to keep the session file clean
			pre_save_cmds = { "NvimTreeClose" },
			post_restore_cmds = { "NvimTreeOpen" },
		})

		local keymap = vim.keymap
		keymap.set("n", "<leader>wr", "<cmd>AutoSession search<CR>", { desc = "Search sessions" })
		keymap.set("n", "<leader>ws", "<cmd>AutoSession save<CR>", { desc = "Save session" })
	end,
}
