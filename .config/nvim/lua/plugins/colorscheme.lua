return {
  {
    -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      transparent = true,
      borderless_telescope = false,
      terminal_colors = true,
      cache = true,
    },

    config = function(_, opts)
      require('cyberdream').setup(opts)

      -- Load the colorscheme here.
      -- vim.cmd.colorscheme 'cyberdream'

      -- You can configure highlights by doing something like:
      -- vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      no_italic = true,
      term_colors = true,
      transparent_background = true,
      color_overrides = {
        mocha = {
          base = '#000000',
          mantle = '#000000',
          crust = '#000000',
        },
      },
      integrations = {
        telescope = {
          enabled = true,
          style = 'nvchad',
        },
      },
    },
  },
  -- {
  --   'navarasu/onedark.nvim',
  --   opts = {
  --     style = 'deep',
  --     transparent = true, -- Show/hide background
  --     term_colors = true, -- Change terminal color as per the selected theme style
  --   },
  --
  --   config = function(_, opts)
  --     require('onedark').setup(opts)
  --
  --     require('onedark').load()
  --   end,
  -- },
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    opts = {
      options = {
        cursorline = false, -- Use cursorline highlighting?
        transparency = true, -- Use a transparent background?
        terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
        lualine_transparency = false, -- Center bar transparency?
        highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
      },
    },

    config = function(_, opts)
      require('onedarkpro').setup(opts)

      -- Load the colorscheme here.
      vim.cmd.colorscheme 'onedark_vivid'
    end,
  },
}

-- return {
--   'folke/tokyonight.nvim',
--   lazy = false,
--   priority = 1000,
--   opts = {},
-- }
--
