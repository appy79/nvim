return {
	vim.api.nvim_create_user_command("FormatProject", function()
		-- Get all files tracked by git, or fallback to all files in pwd
		local handle = io.popen("git ls-files")
		if not handle then
			vim.notify("FormatProject: failed to run `git ls-files`", vim.log.levels.ERROR)
			return
		end
		local result = handle:read("*a")
		handle:close()

		local files = {}
		for file in string.gmatch(result, "[^\r\n]+") do
			table.insert(files, file)
		end

		local conform = require("conform")
		print("Formatting project files...")

		for _, file in ipairs(files) do
			-- Track whether the buffer already existed so we don't wipe
			-- buffers the user already has open.
			local existed = vim.fn.bufexists(file) == 1
			local bufnr = vim.fn.bufadd(file)
			vim.fn.bufload(bufnr)

			-- Skip files conform has nothing (formatter or LSP) to run on, so
			-- we don't needlessly touch them.
			local formatters, lsp_will_format = conform.list_formatters_to_run(bufnr)
			if #formatters > 0 or lsp_will_format then
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

			-- Avoid memory bloat: wipe buffers we loaded that weren't open before.
			if not existed and vim.api.nvim_buf_is_valid(bufnr) then
				vim.api.nvim_buf_delete(bufnr, { force = false })
			end
		end
		print("Project formatting complete!")
	end, {}),
}
