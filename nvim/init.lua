-------------------------------------------------------------------------------
-- Plugins/Packages
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

require("lazy").setup({
	{ "romainl/vim-qf" },
	{ "tpope/vim-repeat" },
	{ "wellle/targets.vim" },
	{ "tpope/vim-fugitive" },
	{ "unblevable/quick-scope" },
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"numToStr/Comment.nvim",
		lazy = false,
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"ethanholz/nvim-lastplace",
		config = function()
			require("nvim-lastplace").setup()
		end,
	},
	{
		"alexghergh/nvim-tmux-navigation",
		config = function()
			require("nvim-tmux-navigation").setup({
				disable_when_zoomed = false,
				keybindings = { left = "<C-h>", down = "<C-j>", up = "<C-k>", right = "<C-l>" },
			})
		end,
	},
	{
		"sontungexpt/buffer-closer",
		event = "VeryLazy",
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
		end,
	},
	{
		"sindrets/diffview.nvim",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"yorickpeterse/nvim-pqf", -- pretty quickfix window
		config = function()
			require("pqf").setup()
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		config = function()
			require("bqf").setup({})
		end,
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
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup({})
		end,
	},
	{
		"ibhagwan/smartyank.nvim",
		config = function()
			require("smartyank").setup({
				highlight = {
					enabled = true,
					higroup = "Search",
					timeout = 250,
				},
			})
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		config = function()
			require("smart-splits").setup()
		end,
	},
	{
		"levouh/tint.nvim",
		config = function()
			require("tint").setup({
				tint = -15,
				highlight_ignore_patterns = { "WinSeparator", "Status.*", "LeapLabelPrimary" },
			})
			-- require("tint").disable()
		end,
	},

	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").setup({})
			require("leap").opts.safe_labels = {}
			require("leap").opts.highlight_unlabeled_phase_one_targets = true
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("lualine").setup({
				options = {
					theme = "ayu",
					section_separators = "",
					component_separators = "",
				},
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon"):setup()
		end,
	},
	{
		"igemnace/vim-makery",
		config = function()
			-- Run make inside docker containers
			vim.g["makery_config"] = {
				["~/dev/nanitor"] = {
					make = {
						makeprg = "docker exec --workdir /nanitor nanitor_dev_env make",
					},
				},
				["~/dev/nancust"] = {
					make = {
						makeprg = "docker exec --workdir /nancust nanitor_dev_env make",
					},
				},
				["~/dev/nanhub-helper"] = {
					make = {
						makeprg = "docker exec --workdir /nanhub-helper nanitor_dev_env make",
					},
				},
				["~/dev/nanitor-scraper"] = {
					make = {
						makeprg = "docker exec --workdir /nanitor-scraper nanitor_dev_env make",
					},
				},
			}
		end,
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
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"go",
					"python",
					"javascript",
					"typescript",
					"rust",
					"vim",
					"vimdoc",
					"lua",
				},
				highlight = { enable = true },
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
			})
		end,
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
						Operator = { fg = "#F43753" },
						CurSearch = { fg = "#000000", bg = "#05ffa1" },
						Tag = { fg = "#000000" },
						NonText = { fg = "#393f49" },
					}
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
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
				attach_to_untracked = false,
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
				yadm = {
					enable = false,
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
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(_, bufnr)
				lsp_zero.default_keymaps({ buffer = bufnr })
			end)

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls", "tsserver", "pylsp", "rust_analyzer" },
				handlers = {
					lsp_zero.default_setup,
					pylsp = function()
						require("lspconfig").pylsp.setup({
							settings = {
								pylsp = {
									plugins = {
										pycodestyle = {
											enabled = true,
											-- Line Too long, line break before binary operator
											ignore = { "E226", "E501", "W503" },
										},
									},
								},
							},
						})
					end,
					gopls = function()
						require("lspconfig").gopls.setup({
							settings = {
								gopls = {
									env = {
										GOOS = "linux",
										GOFLAGS = "-tags=linux",
									},
									buildFlags = {
										"-tags=linux,windows,darwin,integration",
									},
									directoryFilters = {
										"-cmd/nanitor-scap/internal/scap",
										"-cmd/nanitor-scap/internal/openscap",
										"-contrib/submodules",
									},
									staticcheck = true,
									analyses = {
										ST1006 = false, -- Poorly chosen receiver name (allow this/self)
										ST1005 = false, -- Error strings should not be capitalized
										fieldalignment = false,
										nilness = false,
									},
								},
							},
						})
					end,
				},
			})
			local cmp = require("cmp")
			cmp.setup({
				completion = { keyword_length = 3 },
				sources = {
					{ name = "nvim_lsp" },
					{ name = "nvim_lua" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = {
					["<C-y>"] = cmp.mapping.confirm({ select = false }),
					["<C-e>"] = cmp.mapping.abort(),
					["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
					["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
					["<C-p>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
					["<C-n>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_next_item({ behavior = "insert" })
						else
							cmp.complete()
						end
					end),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {},
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = false,
				},
				formatters_by_ft = {
					go = { "gofmt" },
					lua = { "stylua" },
					sql = { "pg_format" },
					tex = { "latexindent" },
					rust = { "rustfmt" },
					typescript = { "eslint_d" },
				},
			})
		end,
	},
})

-------------------------------------------------------------------------------
-- Options
-------------------------------------------------------------------------------
vim.opt.hidden = true

vim.opt.termguicolors = true
vim.opt.lazyredraw = true

vim.opt.undofile = true
vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

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

vim.opt.signcolumn = "auto:2"

vim.opt.winbar = "%{%v:lua.vim.fn.expand('%:~:.')%}" -- relative to cwd

vim.opt.list = true
vim.opt.listchars = {
	tab = "› ",
	trail = "•",
	extends = "#",
	nbsp = ".",
}

-------------------------------------------------------------------------------
-- Keymaps
-------------------------------------------------------------------------------
vim.g.mapleader = " "

-- Turn off search highlights
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>")

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

-- LSP dynamic workspace symbols
vim.keymap.set("n", "<leader>s", ":Telescope lsp_dynamic_workspace_symbols<CR>")

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

-- Quickfix list toggle
vim.keymap.set("n", "<leader>q", "<Plug>(qf_qf_toggle)<CR>")

-- Diff against origin/development
vim.keymap.set("n", "<leader>dd", ":Diffdevelopment<CR>")

-- Harpoon
local harpoon = require("harpoon")
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end)
vim.keymap.set("n", "<leader>l", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "[l", function()
	harpoon:list():prev({ ui_nav_wrap = true })
end)
vim.keymap.set("n", "]l", function()
	harpoon:list():next({ ui_nav_wrap = true })
end)
vim.keymap.set("n", "<leader>1", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
	harpoon:list():select(3)
end)

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

-- Leap
vim.keymap.set("n", "<leader>j", function()
	local current_window = vim.fn.win_getid()
	require("leap").leap({ target_windows = { current_window } })
end)

-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------
---- Show cursorline only in active window
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

-- Tint window when using Leap
local leap_tint_group = vim.api.nvim_create_augroup("leap-ast", {})
vim.api.nvim_create_autocmd("User", {
	group = leap_tint_group,
	pattern = "LeapEnter",
	callback = function()
		require("tint").tint(vim.api.nvim_get_current_win())
	end,
})
vim.api.nvim_create_autocmd("User", {
	group = leap_tint_group,
	pattern = "LeapLeave",
	callback = function()
		require("tint").untint(vim.api.nvim_get_current_win())
	end,
})

-------------------------------------------------------------------------------
-- Commands
-------------------------------------------------------------------------------
-- Diffs current local branch against origin/development
vim.api.nvim_create_user_command("Diffdevelopment", "DiffviewOpen origin/development", {})

-------------------------------------------------------------------------------
-- Colorscheme/Theming
-------------------------------------------------------------------------------
vim.cmd.colorscheme("ayu")
vim.api.nvim_set_hl(0, "CursorLine", { fg = "none", bg = "gray12", default = false })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#242A35", bg = "None", default = true })

-- Quickscope colors
vim.api.nvim_set_hl(0, "QuickScopePrimary", { fg = "#afff5f" })
vim.api.nvim_set_hl(0, "QuickScopeSecondary", { fg = "#FF00FF" })

-- Gitsigns colors
vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#FFEE99", bg = "None", default = true })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#59C2FF", bg = "None", default = false })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#FF3333", bg = "None", default = false })
vim.api.nvim_set_hl(0, "GitSignsTopDelete", { fg = "#FF3333", bg = "None", default = false })
vim.api.nvim_set_hl(0, "GitSignsChangedDelete", { fg = "#FF8F40", bg = "None", default = false })

-- Treesitter
vim.api.nvim_set_hl(0, "@variable.member.go", { fg = "#B3B1AD" })

-- Leap
vim.api.nvim_set_hl(0, "LeapLabelPrimary", { fg = "#afff5f" })
