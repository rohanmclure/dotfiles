local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require('packer').startup(
  function(use)
    use 'wbthomason/packer.nvim'

    -- General Development Experience
    use {
    "klen/nvim-config-local",
      config = function()
        require('config-local').setup {
          -- Default configuration (optional)
          config_files = { ".nvimrc.lua", ".nvimrc" },  -- Config file patterns to load (lua supported)
          hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
          autocommands_create = true,                 -- Create autocommands (VimEnter, DirectoryChanged)
          commands_create = true,                     -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
          silent = false,                             -- Disable plugin messages (Config loaded/ignored)
          lookup_parents = false,                     -- Lookup config files in parent directories
        }
      end
    }
    use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {'williamboman/mason.nvim'},           -- Optional
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},         -- Required
        {'hrsh7th/cmp-nvim-lsp'},     -- Required
        {'hrsh7th/cmp-buffer'},       -- Optional
        {'hrsh7th/cmp-path'},         -- Optional
        {'saadparwaiz1/cmp_luasnip'}, -- Optional
        {'hrsh7th/cmp-nvim-lua'},     -- Optional

        -- Snippets
        {'L3MON4D3/LuaSnip'},             -- Required
        {'rafamadriz/friendly-snippets'}, -- Optional
      }
    }
    use 'terrortylor/nvim-comment'
    use 'LionC/nest.nvim'
    use 'tpope/vim-fugitive'
    use {
      "glepnir/lspsaga.nvim",
      branch = "main",
      requires = {
        {"nvim-tree/nvim-web-devicons"},
        {"nvim-treesitter/nvim-treesitter"}
      }
    }
    use {
      "ThePrimeagen/harpoon",
      requires = { "nvim-lua/plenary.nvim" }
    }

    -- Persistence and Projects
    use 'rmagatti/auto-session'
    use {
      'nvim-telescope/telescope-project.nvim',
      requires = {
        {'nvim-telescope/telescope.nvim'},              -- Required
        {'nvim-telescope/telescope-file-browser.nvim'}  -- Optional
      }
    }

    -- UI Components
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- Optional
      },
    }
    use 'antosha417/nvim-lsp-file-operations'
    use {
      "folke/trouble.nvim",
      requires = "nvim-tree/nvim-web-devicons"
    }
    use 'nvim-treesitter/nvim-treesitter'
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/plenary.nvim'}, -- Required
      }
    }
    use 'nvim-telescope/telescope-live-grep-args.nvim'
    use {
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig"
    }
    use 'morhetz/gruvbox'
    use {
      'akinsho/bufferline.nvim',
      requires = 'nvim-tree/nvim-web-devicons' --Required
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' } --Optional
    }
    use "lukas-reineke/indent-blankline.nvim"
    use {
      'lewis6991/gitsigns.nvim',
      tag = 'release'
    }
    use 'wfxr/minimap.vim'
    use {
      "folke/zen-mode.nvim",
      requires = { 'folke/twilight.nvim' }
    }

    if packer_bootstrap then
      require('packer').sync()
    end
end)
