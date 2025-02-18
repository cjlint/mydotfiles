-- Set up nvim-cmp.
local cmp = require("cmp")
vim.lsp.set_log_level("info")
--vim.lsp.set_log_level("off")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.scroll_docs(-4),
		["<C-p>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- Setup language servers.
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"graphql",
		"tailwindcss",
		"lua_ls",
		"vimls",
		"bashls",
		"omnisharp",
		"terraformls",
		"tflint",
		"pyright",
		--"gopls",
		"dockerls",
		"rust_analyzer",
	},
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.graphql.setup({
	capabilities = capabilities,
	filetypes = { "graphql", "typescript", "javascript", "typescriptreact", "javascriptreact" },
})
lspconfig.tailwindcss.setup({
	capabilities = capabilities,
	filetypes = { "html", "html.handlebars", "handlebars", "hbs", "css" },
	init_options = {
		userLanguages = {
			["html.handlebars"] = "handlebars",
		},
	},
	settings = {
		tailwindCSS = {
			includeLanguages = {
				["html.handlebars"] = "handlebars",
			},
		},
	},
})
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.vimls.setup({ capabilities = capabilities })
lspconfig.bashls.setup({ capabilities = capabilities })
lspconfig.omnisharp.setup({ capabilities = capabilities })
lspconfig.terraformls.setup({ capabilities = capabilities })
lspconfig.tflint.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
--lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.dockerls.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<C-k>", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<C-j>", vim.diagnostic.goto_next)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
	end,
})

-- vim polyglot is installed which provides good syntax highlighting
-- however lsps also provide syntax highlighting which overrides it
-- disable them on a case-by-case basis for now
local disable_lsp_syntax_highlighting = {
	["tsserver"] = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if disable_lsp_syntax_highlighting[client.name] then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
