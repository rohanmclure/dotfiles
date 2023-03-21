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
    use 'rmagatti/auto-session'
    use 'LionC/nest.nvim'
    use 'tpope/vim-fugitive'

    -- UI Components
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- Optional
      },
    }
    use 'antosha417/nvim-lsp-file-operations'
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

    if packer_bootstrap then
      require('packer').sync()
    end
end)
