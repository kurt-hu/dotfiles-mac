return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",

		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"diff",
				"html",
				"javascript",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			lazy = false,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
		},
	},
	-- There are additional nvim-treesitter modules that you can use to interact
	-- with nvim-treesitter. You should go explore a few and see what interests you:
	--
	--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
	--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
	--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				opts = {
					max_lines = 5,
				},
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					-- Defaults
					enable_close = true, -- Auto close tags
					enable_rename = true, -- Auto rename pairs of tags
					enable_close_on_slash = false, -- Auto close on trailing </
				},
				-- Also override individual filetype configs, these take priority.
				-- Empty by default, useful if one of the "opts" global settings
				-- doesn't work well in a specific filetype
				per_filetype = {},
			})
		end,
	},
}
