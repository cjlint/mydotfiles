local eslint_d = require("formatter.defaults.eslint_d")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		typescript = { eslint_d },
		typescriptreact = { eslint_d },
		javascript = { eslint_d },
		javascriptreact = { eslint_d },
		graphql = { eslint_d },
		handlebars = {
			function()
				return {
					exe = "prettierd",
					args = { "--parser", "glimmer" },
					stdin = true,
				}
			end,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		["*"] = { require("formatter.defaults.prettierd") },
	},
})
