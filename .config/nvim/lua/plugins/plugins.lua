-- This file contains various plugins with little to no setup
return {
	-- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-obsession",
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({
				direction = "float",
				open_mapping = [[<c-\>]], -- Ctrl + \
			})
		end,
	}, -- for smart terminal
	{
		"folke/snacks.nvim",
		---@type snacks.Config
		opts = {
			explorer = {
				-- your explorer configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				replace_netrw = true,
			},
			picker = {
				-- taken from https://ricoberger.de/blog/posts/neovim-extend-snacks-nvim-explorer/
				enabled = true,
				sources = {
					explorer = {
						auto_close = false,
						hidden = true,
						layout = {
							preset = "right",
							preview = false,
						},
						actions = {
							copy_file_path = {
								action = function(_, item)
									if not item then
										return
									end

									local vals = {
										["BASENAME"] = vim.fn.fnamemodify(item.file, ":t:r"),
										["EXTENSION"] = vim.fn.fnamemodify(item.file, ":t:e"),
										["FILENAME"] = vim.fn.fnamemodify(item.file, ":t"),
										["PATH"] = item.file,
										["PATH (CWD)"] = vim.fn.fnamemodify(item.file, ":."),
										["PATH (HOME)"] = vim.fn.fnamemodify(item.file, ":~"),
										["URI"] = vim.uri_from_fname(item.file),
									}

									local options = vim.tbl_filter(function(val)
										return vals[val] ~= ""
									end, vim.tbl_keys(vals))
									if vim.tbl_isempty(options) then
										vim.notify("No values to copy", vim.log.levels.WARN)
										return
									end
									table.sort(options)
									vim.ui.select(options, {
										prompt = "Choose to copy to clipboard:",
										format_item = function(list_item)
											return ("%s: %s"):format(list_item, vals[list_item])
										end,
									}, function(choice)
										local result = vals[choice]
										if result then
											vim.fn.setreg("+", result)
											Snacks.notify.info("Yanked `" .. result .. "`")
										end
									end)
								end,
							},
							search_in_directory = {
								action = function(_, item)
									if not item then
										return
									end
									local dir = vim.fn.fnamemodify(item.file, ":p:h")
									Snacks.picker.grep({
										cwd = dir,
										cmd = "rg",
										args = {
											"-g",
											"!.git",
											"-g",
											"!node_modules",
											"-g",
											"!dist",
											"-g",
											"!build",
											"-g",
											"!coverage",
											"-g",
											"!.DS_Store",
											"-g",
											"!.docusaurus",
											"-g",
											"!.dart_tool",
										},
										show_empty = true,
										hidden = true,
										ignored = true,
										follow = false,
										supports_live = true,
									})
								end,
							},
							diff = {
								action = function(picker)
									picker:close()
									local sel = picker:selected()
									if #sel > 0 and sel then
										Snacks.notify.info(sel[1].file)
										vim.cmd("tabnew " .. sel[1].file)
										vim.cmd("vert diffs " .. sel[2].file)
										Snacks.notify.info("Diffing " .. sel[1].file .. " against " .. sel[2].file)
										return
									end

									Snacks.notify.info("Select two entries for the diff")
								end,
							},
						},
						win = {
							list = {
								keys = {
									["y"] = "copy_file_path",
									["s"] = "search_in_directory",
									["D"] = "diff",
								},
							},
						},
					},
				},
				formatters = {
					file = {
						truncate = 60,
					},
				},
			},
			lazygit = {},
		},
		keys = {
			{
				"<leader>sf",
				function()
					Snacks.picker.files()
				end,
				desc = "[S]earch [F]iles (snacks)",
			},
			{
				"<leader>sg",
				function()
					Snacks.picker.grep()
				end,
				desc = "[S]earch by [G]rep (snacks)",
			},
			{
				"<leader>so",
				function()
					Snacks.picker.smart()
				end,
				desc = "[S]mart [O]pen files (snacks)",
			},
			{
				"<leader>e",
				function()
					Snacks.explorer()
				end,
				desc = "File [E]xplorer",
			},
			{
				"<leader>lg",
				function()
					---@param opts? snacks.lazygit.Config
					Snacks.lazygit.open(opts)
				end,
				desc = "[L]azy[G]it",
			},
		},
	},
	{
		"otavioschwanck/arrow.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			-- or if using `mini.icons`
			-- { "echasnovski/mini.icons" },
		},
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
		},
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		opts = {
			-- add any custom options here
		},
		keys = {
			{
				"<leader>pl",
				function()
					require("persistence").load()
				end,
				desc = "[P]ersistence [L]oad (curr dir)",
			},
			{
				"<leader>pf",
				function()
					require("persistence").select()
				end,
				desc = "[P]ersistence [F]ind",
			},
			{
				"<leader>pp",
				function()
					require("persistence").load({ last = true })
				end,
				desc = "[P]ersistence load [P]revious session",
			},
			{
				"<leader>ps",
				function()
					require("persistence").stop()
				end,
				desc = "[P]ersistence [S]top",
			},
		},
	},
	{
		"fatih/vim-go",
		config = function()
			vim.g.go_highlight_types = 0
			vim.g.go_highlight_fields = 0
			vim.g.go_highlight_functions = 0
			vim.g.go_highlight_function_parameters = 0
			vim.g.go_highlight_function_calls = 0
			vim.g.go_highlight_extra_types = 0
			vim.g.go_highlight_build_constraints = 0
			vim.g.go_highlight_generate_tags = 0

			-- disable vim-go :GoDef short cut (gd)
			-- this is handled by LanguageClient [LC]
			vim.g.go_def_mapping_enabled = 0
			vim.g.go_code_completion_enabled = 0
			vim.g.go_doc_keywordprg_enabled = 0

			-- Auto formatting and importing
			vim.g.go_fmt_autosave = 1
			vim.g.go_fmt_command = "goimports"
			vim.g.go_gopls_enabled = 0

			local go_module = vim.fn.systemlist("go list -m")
			if vim.v.shell_error == 0 then
				vim.g.go_fmt_options = { gofmt = "-s", goimports = "-local " .. go_module[1] }
			end
		end,
		event = "VeryLazy",
	}, -- vim-go provides additional functionality on top of the go lsp
	-- {
	-- 	"danielfalk/smart-open.nvim",
	-- 	branch = "0.2.x",
	-- 	config = function()
	-- 		require("telescope").load_extension("smart_open")
	--
	-- 		vim.keymap.set("n", "<leader>so", function()
	-- 			require("telescope").extensions.smart_open.smart_open()
	-- 		end, { noremap = true, silent = true, desc = "[S]mart [O]pen" })
	-- 	end,
	-- 	dependencies = {
	-- 		"kkharji/sqlite.lua",
	-- 		-- Only required if using match_algorithm fzf
	-- 		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	-- 	},
	-- },
	{
		"mbbill/undotree",
		config = function()
			vim.g.undotree_DiffAutoOpen = 1
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_ShortIndicators = 1
			vim.g.undotree_DiffpanelHeight = 20
			vim.g.undotree_SplitWidth = 50
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndotree toggle" })

			if vim.fn.has("persistent_undo") then
				local target_path = vim.fn.expand("~/.undotree-dir")

				-- create the directory and any parent directories
				-- if the location does not exist.
				if vim.fn.isdirectory(target_path) == 0 then
					vim.fn.mkdir(target_path, "p", "0o700")
				end

				vim.opt.undodir = target_path
				vim.opt.undofile = true
			end
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		config = function()
			require("render-markdown").setup({})
		end,
	},
	-- nvim v0.8.0
	-- {
	-- 	"kdheepak/lazygit.nvim",
	-- 	lazy = true,
	-- 	cmd = {
	-- 		"LazyGit",
	-- 		"LazyGitConfig",
	-- 		"LazyGitCurrentFile",
	-- 		"LazyGitFilter",
	-- 		"LazyGitFilterCurrentFile",
	-- 	},
	-- 	-- optional for floating window border decoration
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	-- setting the keybinding for LazyGit with 'keys' is recommended in
	-- 	-- order to load the plugin when the command is run for the first time
	-- 	keys = {
	-- 		{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
	-- 	},
	-- },
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			-- you'll need at least one of these
			{ "nvim-telescope/telescope.nvim" },
			-- {'ibhagwan/fzf-lua'},

			-- for persistent storage
			{ "kkharji/sqlite.lua", module = "sqlite" },
		},
		config = function()
			require("neoclip").setup({
				enable_persistent_history = true,

				keys = {
					telescope = {
						i = {
							select = "<cr>",
							paste = "<c-y>",
							paste_behind = "<c-k>",
							replay = "<c-q>", -- replay a macro
							delete = "<c-d>", -- delete an entry
							edit = "<c-e>", -- edit an entry
							custom = {},
						},
						n = {
							select = "<cr>",
							paste = "p",
							--- It is possible to map to more than one key.
							-- paste = { 'p', '<c-p>' },
							paste_behind = "P",
							replay = "q",
							delete = "d",
							edit = "e",
							custom = {},
						},
					},
					fzf = {
						select = "default",
						paste = "ctrl-y",
						paste_behind = "ctrl-k",
						custom = {},
					},
				},
			})
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {
			jump = {
				autojump = true,
			},
			label = {
				rainbow = {
					enabled = true,
				},
			},
			modes = {
				char = {
					jump_labels = true,
					multi_line = true,
				},
			},
		},
    -- stylua: ignore
    keys = {
      { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		commit = "e7a4442e055ec953311e77791546238d1eaae507",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		config = function()
			local highlight = {
				"RainbowRed",
				"RainbowYellow",
				"RainbowBlue",
				"RainbowOrange",
				"RainbowGreen",
				"RainbowViolet",
				"RainbowCyan",
			}
			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
			end)

			vim.g.rainbow_delimiters = { highlight = highlight }
			require("ibl").setup({ scope = { highlight = highlight } })

			hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
		end,
	},
	{
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup({
				resize = {
					enable_default_keybindings = false,
				},
			})
		end,
	},
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	version = "*",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	cmd = "Neotree",
	-- 	keys = {
	-- 		{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	-- 	},
	-- 	opts = {
	-- 		filesystem = {
	-- 			window = {
	-- 				mappings = {
	-- 					["\\"] = "close_window",
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- Optional dependency
		dependencies = { "hrsh7th/nvim-cmp" },
		config = function()
			require("nvim-autopairs").setup({})
			-- If you want to automatically add `(` after selecting a function or method
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	-- {
	-- 	"alexghergh/nvim-tmux-navigation",
	-- 	event = "VeryLazy",
	-- 	config = function()
	-- 		local nvim_tmux_nav = require("nvim-tmux-navigation")
	-- 		nvim_tmux_nav.setup({
	-- 			disable_when_zoomed = true,
	-- 			-- defaults to false
	-- 			keybindings = {
	-- 				left = "<C-h>",
	-- 				down = "<C-j>",
	-- 				up = "<C-k>",
	-- 				right = "<C-l>",
	-- 				last_active = "<C-\\>",
	-- 				next = "<C-Space>",
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	--  config = function() ... end

	-- NOTE: Plugins can specify dependencies.
	--
	-- The dependencies are proper plugin specifications as well - anything
	-- you do for a plugin at the top level, you can do for a dependency.
	--
	-- Use the `dependencies` key to specify the dependencies of a particular plugin

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
}
