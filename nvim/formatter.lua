local eslint_d = require('formatter.defaults.eslint_d')
local prettierd = require('formatter.defaults.prettierd')

require('formatter').setup({
  logging = true,
  log_level = vim.log.levels.WARN,
  filetype = {
    typescript = {eslint_d},
    typescriptreact = {eslint_d},
    javascript = {eslint_d},
    javascriptreact = {eslint_d},
    graphql = {eslint_d},
    ["*"] = {prettierd}
  }
})
