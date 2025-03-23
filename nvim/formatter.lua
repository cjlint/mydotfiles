local eslint_d = require("formatter.defaults.eslint_d")
local prettierd = require("formatter.defaults.prettierd")
local prettier = require("formatter.defaults.prettier")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--edition", "2024", "-q", "--emit", "stdout" },
					stdin = true,
				}
			end,
		},
		typescript = { eslint_d, prettier },
		typescriptreact = { eslint_d, prettier },
		javascript = { eslint_d, prettier },
		javascriptreact = { eslint_d, prettier },
		html = { prettierd },
		graphql = { eslint_d, prettierd },
		json = { prettierd },
		toml = { prettierd },
		markdown = { prettierd },
		python = {
			function()
				return {
					exe = "ruff",
					args = { "check", "--select", "I", "--fix" },
				}
			end,
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
		handlebars = { prettierd },
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
