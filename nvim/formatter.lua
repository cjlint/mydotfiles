local eslint_d = require("formatter.defaults.eslint_d")
local prettierd = require("formatter.defaults.prettierd")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		typescript = { eslint_d, prettierd },
		typescriptreact = { eslint_d, prettierd },
		javascript = { eslint_d, prettierd },
		javascriptreact = { eslint_d, prettierd },
		graphql = { eslint_d, prettierd },
		json = { prettierd },
		markdown = { prettierd },
		python = {
			function()
				return {
					exe = "ruff",
					args = { "format" },
				}
			end,
		},
		go = {
			function()
				return {
					exe = "gofmt",
					stdin = true,
				}
			end,
		},
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
		terraform = {
			function()
				return {
					exe = "terraform",
					args = { "fmt" },
				}
			end,
		},
	},
})
