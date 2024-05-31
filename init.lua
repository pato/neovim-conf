-- Bootstrap lazynvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

local opt = vim.opt

opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.autowrite = true -- Enable auto write
opt.mouse = "a" -- Enable mouse mode in all modes

opt.number = true -- display line number
opt.relativenumber = true -- Relative line numbers
opt.showmatch = true -- Highlight matching parenthesis

opt.list = true -- Show some invisible characters (tabs...
opt.cursorline = true -- Enable highlighting of the current line
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.shiftround = true -- Round indent
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.updatetime = 300 -- Save swap file and trigger CursorHold of no cursor movement

opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "screen"

opt.incsearch = true -- incrementally display search results
opt.inccommand = "nosplit" -- preview incremental substitute
opt.hlsearch = true -- highlight search results
opt.ignorecase = true -- ignore case in searches by default
opt.smartcase = true -- but make it case sensitive if an uppercase is entered

opt.autoindent = true -- automatically indent
opt.expandtab = true -- Use spaces instead of tabs
opt.tabstop = 2 -- Number of spaces tabs count for
opt.shiftwidth = 2 -- Size of an indent

opt.undofile = true -- enable persistent undo
opt.undolevels = 1000 -- lots of levels
opt.undoreload = 10000 -- save the whole buffer for undo when reloading it
opt.undodir = vim.fn.stdpath("config") .. "/.undo" -- put them all in the same place

opt.breakindent = true -- enable break indent
opt.scrolloff = 10 -- minimum number of screen lines to keep above/below cursor

if vim.g.neovide then
	-- Configure gui font
	--vim.o.guifont = "Hack Nerd Font Mono:h13"
	vim.o.guifont = "Rec Mono Semicasual:h13"
	-- Make the animations less in your face
	vim.g.neovide_cursor_animation_length = 0.05
	vim.g.neovide_cursor_trail_size = 0.2
	-- General quality of life improvements
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_theme = "auto"
	-- Allow clipboard copy paste in neovide
	vim.g.neovide_input_use_logo = 1
	vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
end

-- Let's not pretend that we don't constantly mistype shift
vim.cmd("command! -nargs=* W w")
vim.cmd("command! -nargs=* Wq wq")
vim.cmd("command! -nargs=* WQ wq")
vim.cmd("command! -nargs=* Q q")
vim.cmd("command! -nargs=* Qa qa")
vim.cmd("command! -nargs=* QA qa")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear highlights

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true -- enable smoothscroll
end

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.g.have_nerd_font = true

vim.g.rustaceanvim = { -- rustaceanvim/rust-tools options
	tools = {
		enable_clippy = false,
	},
	server = { -- lsp server options
		on_attach = function(_, bufnr) -- fn(client, bufnr)
			local opts = { noremap = true, silent = true }
			vim.api.nvim_set_keymap("n", "gD", "<cmd>RustLsp externalDocs<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>rr", "<cmd>RustLsp runnables<CR>", opts)
			vim.api.nvim_set_keymap("n", "gm", "<cmd>RustLsp parentModule<CR>", opts)
			vim.api.nvim_set_keymap("n", "gc", "<cmd>RustLsp openCargo<CR>", opts)
			vim.api.nvim_set_keymap("n", "<leader>ga", "<cmd>lua vim.cmd.RustLsp('codeAction')<CR>", opts) -- has grouping
			vim.api.nvim_set_keymap("n", "g,", "<cmd>RustLsp renderDiagnostic<CR>", opts)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"s",
				'<cmd>lua require("tree_climber_rust").init_selection()<CR>',
				opts
			)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"x",
				"s",
				'<cmd>lua require("tree_climber_rust").select_incremental()<CR>',
				opts
			)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"x",
				"S",
				'<cmd>lua require("tree_climber_rust").select_previous()<CR>',
				opts
			)
		end,
		settings = {
			["rust-analyzer"] = { -- https://rust-analyzer.github.io/manual.html
				checkOnSave = true,
			},
		},
	},
}

require("lazy").setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-surround", -- Allow deleting/adding based on surrounding characters
	"tpope/vim-repeat", -- Allow repeating plugin actions (such as surround actions)

	{ -- Provides ":Bdelete hidden"
		"Asheq/close-buffers.vim",
		cmd = "Bdelete",
	},

	{ -- my favorite theme
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		init = function()
			vim.cmd.colorscheme("tokyonight")
		end,
	},

	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {},
		event = "VeryLazy",
	},

	{ -- Rust Analyzer plugin for better support
		"mrcjkb/rustaceanvim",
		version = "^4", -- Recommended
		ft = { "rust" },
	},

	{ -- Treesitter incremental tree walking for Rust
		"adaszko/tree_climber_rust.nvim",
		dependencies = {
			"mrcjkb/rustaceanvim",
		},
		keys = { "s" },
	},

	{ -- Better default UI elements
		"stevearc/dressing.nvim",
		opts = {},
		event = "VeryLazy",
	},

	{ -- Fugitive style Git blame, <TAB>/<BS> to push/pop commit stack view. i for info
		"FabijanZulj/blame.nvim",
		config = function()
			require("blame").setup()
		end,
		cmd = "BlameToggle",
	},

	{ -- Because life is too short to type closing parens
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },
			{ "smilovanovic/telescope-search-dir-picker.nvim" },
			{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						-- i = { ["<c-enter>"] = "to_fuzzy_refine" },
						-- i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
						-- n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
					},
				},
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")
			pcall(require("telescope").load_extension, "search_dir_picker")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>gr", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

			vim.keymap.set("n", "<C-P>", builtin.find_files, { desc = "Search across files" })
			vim.keymap.set("n", "<leader>fo", builtin.find_files, { desc = "Search across files" })
			vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Search across git-tracked files" })
			vim.keymap.set("n", "<leader>ff", builtin.live_grep, { desc = "Live grep across project" })
			vim.keymap.set("n", "ge", builtin.diagnostics, { desc = "[G]oto [D]iagnostics" })
			-- vim.keymap.set("n", "<leader>fd", builtin.search_dir_picker, { desc = "Live grep in a picked irectory" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{ -- Buffer-based file tree plugin
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Oil",
		keys = { { "-", "<CMD>Oil<CR>", desc = "Open parent directory with Oil" } },
	},

	{ -- Because I wish I had Emac's magit
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim", -- optional
		},
		opts = {},
		cmd = "Neogit",
		keys = { { "<leader>gt", "<CMD>Neogit kind=vsplit<CR>", desc = "Open Neogit in a vertical split" } },
	},

	{ -- auto-save sessions
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
			})
		end,
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gW", require("telescope.builtin").lsp_document_symbols, "[G]oto document symbols")
					map("gw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[G]oto workspace symbols")
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					vim.api.nvim_set_keymap(
						"n",
						"g.",
						"<cmd>lua vim.diagnostic.open_float(nil, { focusable = false })<CR>",
						{ silent = true }
					)
					vim.api.nvim_set_keymap("n", "g[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true })
					vim.api.nvim_set_keymap("n", "g]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true })
					vim.api.nvim_set_keymap("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
					vim.api.nvim_set_keymap("x", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<space>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					-- map("ga", vim.lsp.buf.code_action, "Execute code action")
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end

					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						-- 	-- auto enable them for the current buffer
						vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
						-- 	-- create a keymap for toggling inlay hints
						map("<leader>i", function()
							vim.lsp.inlay_hint.enable(
								not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }),
								{ bufnr = event.buf }
							)
						end, "Toggle [I]nlay Hints")
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local servers = {
				-- clangd = {},
				-- gopls = {},
				-- pyright = {},
				rust_analyzer = function() end,
				-- rust_analyzer = {},
				-- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
				--
				-- Some languages (like typescript) have entire language plugins that can be useful:
				--    https://github.com/pmizio/typescript-tools.nvim
				--
				-- But for many setups, the LSP (`tsserver`) will work just fine
				-- tsserver = {},
				--

				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
					["rust_analyzer"] = function()
						return true
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				-- javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<Down>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<Up>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Close and confirm
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Insert,
						select = true,
					}),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "buffer", keyword_length = 5 },
					{ name = "nvim_lsp_signature_help" },
				},
				-- Rank the completions
				sorting = {
					priority_weight = 1.0,
					comparators = {
						cmp.config.compare.locality,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
					},
				},
			})
		end,
	},

	{ -- lualine display
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				globalstatus = true,
			},
			sections = {
				-- commenting this for now as it forces loading of overseer, need to figure out how to add a section but still have it be lazy
				-- lualine_x = { "overseer" },
				lualine_y = { "filetype" },
			},
			extensions = { "lazy", "overseer", "oil", "mason", "toggleterm" },
		},
		event = "VeryLazy",
	},

	{ -- display TODOs prominently
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{ -- for task running
		"stevearc/overseer.nvim",
		opts = {},
		config = function()
			vim.keymap.set(
				"n",
				"<leader>cc",
				"<CMD>OverseerRunCmd cargo check --all-targets<CR>",
				{ desc = "Run cargo check --all-targets with overseer" }
			)
			vim.keymap.set(
				"n",
				"<leader>cl",
				"<CMD>OverseerRunCmd make clippy<CR>",
				{ desc = "Run make clippy with overseer" }
			)
			vim.keymap.set(
				"n",
				"<leader>cf",
				"<CMD>OverseerRunCmd make fmt<CR>",
				{ desc = "Run make format with overseer" }
			)
			vim.keymap.set("n", "<leader>cr", "<CMD>OverseerRun<CR>", { desc = "Run command with overseer" })
			vim.keymap.set("n", "<leader>ct", "<CMD>OverseerQuickAction open hsplit<CR>", { desc = "Toggle overseer" })
			vim.keymap.set("n", "<leader>tt", "<CMD>OverseerToggle<CR>", { desc = "[T]oggle overseer" })
			require("overseer").setup()
		end,
		keys = { "<leader>cr", "<leader>ct", "<leader>tt", "<leader>cc", "<leader>cl", "<leaderl>cf" },
	},

	{ -- toggleterm for more ergonomic terminals
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			-- Map Esc to bring us back to normal mode when in terminal
			vim.api.nvim_set_keymap("t", "<ESC>", [[<C-\><C-n>]], { noremap = true })

			require("toggleterm").setup({
				size = function(term)
					if term.direction == "horizontal" then
						return 15
					elseif term.direction == "vertical" then
						return vim.o.columns * 0.4
					end
				end,
				open_mapping = [[<c-\>]],
				hide_numbers = true, -- hide the number column in toggleterm buffers
				shade_terminals = true,
				start_in_insert = true,
				-- direction = 'vertical' | 'horizontal' | 'window' | 'float',
				persist_size = true,
			})
		end,
		opts = {},
		keys = { "<c-\\>" },
	},

	{ -- extend treesitter with text objects
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		-- event = "VeryLazy",
	},

	{ -- treesitter extensions
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				modules = {},
				auto_install = false,
				ignore_install = {},
				ensure_installed = {
					"bash",
					"diff",
					"git_rebase",
					"gitcommit",
					"html",
					"java",
					"lua",
					"markdown",
					"markdown_inline",
					"query",
					"regex",
					"rust",
					"vim",
					"vimdoc",
				},
				sync_install = false, -- don't install ensure_installed synchronously
				highlight = {
					enable = true,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<space>ss",
						node_incremental = "<space>si",
						scope_incremental = "<space>sc",
						node_decremental = "<space>sd",
					},
				},
				indent = { enable = false },
				textobjects = {
					lsp_interop = {
						enable = true,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
					select = {
						enable = true,
						lookahead = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["aa"] = "@parameter.inner",
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
						},
						include_surrounding_whitespace = true,
					},
				},
			})
		end,
		event = "VeryLazy",
	},

	{ -- IDE like experience
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		opts = {},
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>fc", "<cmd>lua require('dropbar.api').pick()<CR>", { silent = true })
		end,
	},

	{ -- pretty diagnostics, references, etc..
		"folke/trouble.nvim",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		cmd = "Trouble",
		opts = {},
	},
})

-- vim: ts=2 sts=2 sw=2 et
