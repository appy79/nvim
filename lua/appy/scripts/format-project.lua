return {
	vim.api.nvim_create_user_command("FormatProject", function()
		-- Get all files tracked by git, or fallback to all files in pwd
		local handle = io.popen("git ls-files")
		local result = handle:read("*a")
		handle:close()

		local files = {}
		for file in string.gmatch(result, "[^\r\n]+") do
			table.insert(files, file)
		end

		local conform = require("conform")
		print("Formatting project files...")

		for _, file in ipairs(files) do
			local bufnr = vim.fn.bufadd(file)
			vim.fn.bufload(bufnr)

			-- Format synchronously to avoid clobbering concurrent file writes
			conform.format({
				bufnr = bufnr,
				async = false,
				lsp_fallback = true,
			}, function(err)
				if not err then
					vim.api.nvim_buf_call(bufnr, function()
						vim.cmd("silent! write")
					end)
				end
			end)
		end
		print("Project formatting complete!")
	end, {}),
}
