return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	opts = function()
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
