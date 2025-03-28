-------------------------------------------------------------------------------
-- PLUGINS/PACKAGES
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: `opts = {}` is the same as calling `require('plugin').setup({})`
require("lazy").setup({
	{ "romainl/vim-qf" },
	{ "tpope/vim-repeat" },
	{ "wellle/targets.vim" },
	{ "tpope/vim-fugitive" },
	{ "unblevable/quick-scope" },
	{ "andymass/vim-matchup" },
	{ "lervag/vimtex" },
	{
		"windwp/nvim-autopairs",
		opts = {},
	},
	{
		"numToStr/Comment.nvim",
		opts = {},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = "VimEnter",
		opts = {
			signs = false,
		},
	},
	{
		"ethanholz/nvim-lastplace",
		opts = {},
	},
	{
		"alexghergh/nvim-tmux-navigation",
		opts = {
			disable_when_zoomed = false,
			keybindings = {
				left = "<C-h>",
				down = "<C-j>",
				up = "<C-k>",
				right = "<C-l>",
			},
		},
	},
	{
		"sontungexpt/buffer-closer",
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"yorickpeterse/nvim-pqf", -- pretty quickfix window
		opts = {},
	},
	{
		"kevinhwang91/nvim-bqf",
		opts = {},
	},
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.bracketed").setup({
				comment = { suffix = "", options = {} },
			})
		end,
	},
	{
		"karb94/neoscroll.nvim",
		opts = {
			easing = "quadratic",
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		opts = {},
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {},
	},
	{
		"ibhagwan/smartyank.nvim",
		opts = {
			highlight = {
				enabled = true,
				higroup = "Search",
				timeout = 250,
			},
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				theme = "ayu",
				section_separators = "",
				component_separators = "",
			},
		},
	},
	{
		"Wansmer/symbol-usage.nvim",
		event = "BufReadPre",
		opts = {
			vt_position = "end_of_line",
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		opts = {
			provider_selector = function(_, _, _)
				return { "treesitter", "indent" }
			end,
		},
	},
	{
		"cbochs/grapple.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons", lazy = true },
		},
		event = { "BufReadPost", "BufNewFile" },
		cmd = "Grapple",
		opts = {
			scope = "git_branch",
		},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			local actions = require("telescope.actions")
			local live_grep_actions = require("telescope-live-grep-args.actions")
			require("telescope").setup({
				defaults = {
					layout_config = {
						width = 0.90,
						height = 0.80,
						preview_cutoff = 120,
					},
					file_ignore_patterns = { "node_modules" },
					mappings = {
						i = {
							["<C-n>"] = actions.cycle_history_next,
							["<C-p>"] = actions.cycle_history_prev,
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-x>"] = actions.delete_buffer,
							["<C-o>"] = live_grep_actions.quote_prompt(),
						},
					},
					extensions = {
						fzf = {
							fuzzy = true,
							override_generic_sorter = true,
							override_file_sorter = true,
							case_mode = "smart_case",
						},
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{ "nvim-treesitter/nvim-treesitter-textobjects" },
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs",
		opts = {
			matchup = {
				enable = true,
			},
			auto_install = true,
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
				},
				move = {
					enable = true,
					set_jumps = true,
					goto_next_start = {
						["]]"] = "@function.outer",
					},
					goto_previous_start = {
						["[["] = "@function.outer",
					},
				},
			},
		},
	},
	{
		"Shatur/neovim-ayu",
		config = function()
			require("ayu").setup({
				-- Turn off italic comments
				overrides = function()
					return {
						Comment = { fg = require("ayu.colors").comment }, -- disable italics
						String = { fg = "#D3B987" },
						Constant = { fg = "#FDF498" },
						Operator = { fg = "#F43753" },
						CurSearch = { fg = "#000000", bg = "#05ffa1" },
						Tag = { fg = "#000000" },
						NonText = { fg = "#393f49" },
						Visual = { bg = "#313C47" },
						LineNr = { fg = "#393f49", bg = "#0A0E14" },
						CursorLineNr = { fg = "#E6B450", bg = "#0A0E14" },
					}
				end,
			})
			vim.cmd.colorscheme("ayu")
			-- Treesitter
			vim.api.nvim_set_hl(0, "@variable.member.go", { fg = "#B3B1AD" })
			vim.api.nvim_set_hl(0, "@type.builtin.go", { fg = "#61afef" }) -- blue
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "—" },
				topdelete = { text = "—" },
				changedelete = { text = "~—" },
				untracked = { text = "┆" },
			},
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = true,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- "eol" | "overlay" | "right_align"
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				border = "single",
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},

			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						return "]c"
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "[c", function()
					if vim.wo.diff then
						return "[c"
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				-- Actions
				map("n", "<leader>hs", gs.stage_hunk)
				map("n", "<leader>hr", gs.reset_hunk)
				map("v", "<leader>hs", function()
					gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("v", "<leader>hr", function()
					gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end)
				map("n", "<leader>hS", gs.stage_buffer)
				map("n", "<leader>hu", gs.undo_stage_hunk)
				map("n", "<leader>hR", gs.reset_buffer)
				map("n", "<leader>hp", gs.preview_hunk)
				map("n", "<leader>hb", function()
					gs.blame_line({ full = true })
				end)
				map("n", "<leader>tb", gs.toggle_current_line_blame)
				map("n", "<leader>hd", gs.diffthis)
				map("n", "<leader>hD", function()
					gs.diffthis("~")
				end)
				map("n", "<leader>td", gs.toggle_deleted)

				-- Text object
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {},
			},
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
			"saghen/blink.cmp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("go", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
					---@param client vim.lsp.Client
					---@param method vim.lsp.protocol.Method
					---@param bufnr? integer some lsp support methods only in specific files
					---@return boolean
					local function client_supports_method(client, method, bufnr)
						if vim.fn.has("nvim-0.11") == 1 then
							return client:supports_method(method, bufnr)
						else
							return client.supports_method(method, { bufnr = bufnr })
						end
					end

					-- Toggle inlay hints
					if
						client
						and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf)
					then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
						end, "[T]oggle Inlay [H]ints")
					end
				end,
			})

			-- Diagnostic Config
			vim.diagnostic.config({
				virtual_lines = true,
				severity_sort = true,
				float = {
					border = "rounded",
					source = "if_many",
				},
				underline = {
					severity = vim.diagnostic.severity.ERROR,
				},
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚",
						[vim.diagnostic.severity.WARN] = "󰀪",
						[vim.diagnostic.severity.INFO] = "󰋽",
						[vim.diagnostic.severity.HINT] = "󰌶",
					},
				},
				virtual_text = not {
					source = "if_many",
					spacing = 0,
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
				},
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local servers = {
				clangd = {},
				lua_ls = {},
				jsonls = {},
				rust_analyzer = {},
				gopls = {
					env = {
						CG_ENABLED = "1",
						GOOS = "linux",
						GOFLAGS = "-tags=darwin",
					},
					buildFlags = {
						"-tags=linux,integration,manual,libbpf,libbcc,arm64,osusergo,netgo",
					},
					directoryFilters = {
						"-libbpf/src",
					},
					staticcheck = true,
					analyses = {
						ST1006 = false, -- Poorly chosen receiver name (allow this/self)
						ST1005 = false, -- Error strings should not be capitalized
						fieldalignment = false,
						nilness = true,
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers or {})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						server.capabilities = vim.tbl_deep_extend(
							"force",
							{},
							capabilities,
							require("blink.cmp").get_lsp_capabilities() or {} -- TODO: fix blink
						)
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = false,
			},
			formatters_by_ft = {
				go = { "gofmt" },
				lua = { "stylua" },
				tex = { "latexindent" },
				rust = { "rustfmt" },
			},
		},
	},
})

-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
vim.opt.hidden = true

vim.g.have_nerd_font = false

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.termguicolors = true
vim.opt.lazyredraw = true -- Good for large files/changes

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.breakindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.cmdheight = 0
vim.opt.laststatus = 3

vim.opt.inccommand = "split"

vim.opt.signcolumn = "auto:2"

vim.opt.winbar = "%{%v:lua.vim.fn.expand('%:~:.')%}" -- relative to cwd

vim.opt.list = true
vim.opt.listchars = {
	tab = "› ",
	trail = "•",
	extends = "#",
	nbsp = "␣",
}

vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true

-------------------------------------------------------------------------------
-- KEYMAPS
-------------------------------------------------------------------------------
-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Turn off search highlights
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>")
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- Move to end of line in insert mode
vim.keymap.set("i", "<C-l>", "<C-o>$")

-- Center screen in insert mode
vim.keymap.set("i", "<C-z>", "<C-o>zz")

-- Move up and down visually
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Enter a blank line above or below the cursor.
vim.keymap.set("n", "<leader>k", "O<Esc>j")
vim.keymap.set("n", "<leader>j", "o<Esc>k")

-- Quick search and replace ("." to confirm, "n" to skip)
vim.keymap.set("n", "c*", "/\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgn")
vim.keymap.set("n", "c#", "?\\<<C-R>=expand('<cword>')<CR>\\>\\C<CR>``cgN")

-- Keep searches in the middle of the screen
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Don't lose focus when visual tabbing
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Jump between last file
vim.keymap.set("n", "<leader>e", ":e #<CR>")

-- Tab navigation
vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "[t", ":tabprevious<CR>")

-- Resize windows
vim.keymap.set("n", "<A-h>", ":lua require('smart-splits').resize_left()<CR>")
vim.keymap.set("n", "<A-l>", ":lua require('smart-splits').resize_right()<CR>")
vim.keymap.set("n", "<A-k>", ":lua require('smart-splits').resize_up()<CR>")
vim.keymap.set("n", "<A-j>", ":lua require('smart-splits').resize_down()<CR>")

-- Quick save (write)
vim.keymap.set("n", "<leader>w", ":w<CR>")

-- Use this for live-grep instead
vim.keymap.set("n", "Q", "<Nop>")

-- Telscope find (git) files
vim.keymap.set(
	"n",
	"<C-p>",
	":lua if not pcall(require('telescope.builtin').git_files, {}) then require('telescope.builtin').find_files({}) end <CR>"
)

-- Live grep (using ripgrep)
vim.keymap.set("n", "<S-q>", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")

-- Buffers and Oldfiles
vim.keymap.set("n", "<C-b>", ":Telescope buffers<CR>")
vim.keymap.set("n", "<C-s>", ":Telescope oldfiles<CR>")

-- Toggle nvim-tree
vim.keymap.set("n", "<F1>", "<Nop>")
vim.keymap.set("n", "<F1>", ":NvimTreeToggle<CR>")

-- Run Make inside docker container
vim.keymap.set("n", "<leader>m", ":Mmake<CR>")

-- Git status (fugitive)
local function fugitive_toggle()
	if vim.fn.buflisted(vim.fn.bufname("fugitive:///*/.git//$")) ~= 0 then
		vim.cmd([[ execute ":bdelete" bufname("fugitive:///*/.git//$") ]])
	else
		vim.cmd([[
        Git
        wincmd V  " Open Git window in vertical split
        setlocal winfixwidth
        horizontal resize 20
        setlocal winfixwidth
    ]])
	end
end
vim.keymap.set("n", "<leader>g", fugitive_toggle)

vim.keymap.set("n", "<leader>L", function()
	vim.diagnostic.config({
		virtual_text = not vim.diagnostic.config().virtual_text,
		virtual_lines = not vim.diagnostic.config().virtual_lines,
	})
end, { desc = "Toggle between diagnostic virtual_lines (default) or virtual_text" })

-- Quickfix list toggle
vim.keymap.set("n", "<leader>q", "<Plug>(qf_qf_toggle)<CR>")

-- Diff against origin/main
vim.keymap.set("n", "<leader>dm", ":Diffmain<CR>")
-- Diff against previous commit
vim.keymap.set("n", "<leader>dd", ":DiffviewOpen<CR>")

-- Grapple
vim.keymap.set("n", "<leader>a", require("grapple").tag)
vim.keymap.set("n", "<leader>l", require("grapple").toggle_tags)
vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>")
vim.keymap.set("n", "<leader>2", "<cmd>Grapple select index=2<cr>")
vim.keymap.set("n", "<leader>3", "<cmd>Grapple select index=3<cr>")
vim.keymap.set("n", "<leader>4", "<cmd>Grapple select index=4<cr>")

-- Insert an if err != nil {...}
local function go_if_err()
	local byte_offset = vim.fn.wordcount().cursor_bytes
	local cmd = ("~/go/bin/iferr" .. " -pos " .. byte_offset)
	local data = vim.fn.systemlist(cmd, vim.fn.bufnr("%"))

	if vim.v.shell_error ~= 0 then
		vim.notify("command " .. cmd .. " exited with code " .. vim.v.shell_error, "error")
		return
	end

	local pos = vim.fn.getcurpos()[2]
	vim.fn.append(pos, data)
	vim.cmd([[silent normal! j=2j]])
	vim.fn.setpos(".", pos)
end
vim.keymap.set("n", "<leader>ie", go_if_err)

-- Fold Go's 'err != nil'
vim.keymap.set("n", "<leader>fe", ":g/s*err != nil /normal za<CR><C-o>:nohlsearch<CR>")

-- Open notes
vim.keymap.set("n", "<leader>n", ":Notes<CR>")

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------
-- Show cursorline only in active window
local cursorline_active_window = vim.api.nvim_create_augroup("CursorlineActiveWindow", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	group = cursorline_active_window,
	command = "setlocal cursorline",
})
vim.api.nvim_create_autocmd({ "WinLeave" }, {
	group = cursorline_active_window,
	command = "setlocal nocursorline",
})

-- Turn off expandtab in go files
local no_expand_tab = vim.api.nvim_create_augroup("NoExpandtab", { clear = true })
vim.api.nvim_create_autocmd({ "FileType", "WinEnter", "BufWinEnter" }, {
	group = no_expand_tab,
	pattern = { "*.go" },
	command = "set noexpandtab",
})

-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------
-- Diffs current local branch against origin/main
vim.api.nvim_create_user_command("Diffmain", "DiffviewOpen origin/main... --imply-local", {})

vim.api.nvim_create_user_command("Notes", "Telescope find_files search_dirs=~/notes", {})
vim.api.nvim_create_user_command("GrepNotes", "Telescope live_grep_args search_dirs=~/notes", {})

-------------------------------------------------------------------------------
-- Colorscheme/Theming
-------------------------------------------------------------------------------
vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = "gray12", default = false })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#242A35", bg = "None", default = true })

-- Quickscope colors
vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#afff5f" })
vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#FF00FF" })

-- Gitsign Colors
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#FFEE99", bg = "None", default = true })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#59C2FF", bg = "None", default = false })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#FF3333", bg = "None", default = false })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = "#FF3333", bg = "None", default = false })
vim.api.nvim_set_hl(0, "GitSignsChangedDelete", { fg = "#FF8F40", bg = "None", default = false })
