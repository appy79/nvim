return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	build = "make",
	opts = function()
		-- Work machine configuration
		if _G.is_work then
			return {
				provider = "cursor",
				mode = "agentic",
				acp_providers = {
					cursor = {
						-- Wrapper patches ACP initialize so Cursor exposes model parameters like fast=false.
						command = os.getenv("HOME") .. "/.local/bin/agent",
						args = { "acp" },
						auth_method = "cursor_login",
						env = {
							HOME = os.getenv("HOME"),
							PATH = os.getenv("PATH"),
						},
					},
				},
			}
		end

		-- Home configuration (Default fallback)
		return {
			provider = "gemini", -- Swap master backend to Gemini API
			providers = {
				gemini = {
					model = "gemini-3.0-pro",
					max_tokens = 4096,
				},
			},
		}
	end,
	--auto_suggestions_provider = "cursor",
	--behaviour = {
	--auto_suggestions = true, -- Activate the inline suggestion framework
	--},

	-- 3. Tune the timing constraints (Optional but highly recommended)
	--suggestion = {
	--debounce = 600, -- Time in ms to wait before generating completion after you stop typing
	--},

	-- Default keymaps to accept or cycle suggestions
	-- 	mappings = {
	-- 		suggestion = {
	-- 			accept = "<M-l>", -- Alt + l to accept the gray text completion
	-- 			next = "<M-]>", -- Alt + ] to view the next suggestion
	-- 			prev = "<M-[>", -- Alt + [ to view the previous suggestion
	-- 			dismiss = "<C-]>", -- Ctrl + ] to clear the current completion overlay
	-- 		},
	-- 	},
	-- },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
