return require('packer').startup(function()

  use 'wbthomason/packer.nvim' -- Package manager

  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

  use 'wellle/targets.vim'
  use 'raimondi/delimitmate'
  use 'unblevable/quick-scope'
  use 'ojroques/nvim-hardline'
  use 'igemnace/vim-makery'
  use 'christoomey/vim-tmux-navigator'

  -- Better quickfix
  use 'romainl/vim-qf'
  use 'kevinhwang91/nvim-bqf'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ":TSUpdate",
  }
  -- Treesitter text objects
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  -- Treesitter context
  use 'nvim-treesitter/nvim-treesitter-context'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {"nvim-telescope/telescope-live-grep-args.nvim"},
    }
  }
  -- Telescope fzf extension
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }

  -- Startup screen
  use 'mhinz/vim-startify'

  -- LSP config
  use 'neovim/nvim-lspconfig'
  -- LSP installer
  use 'williamboman/nvim-lsp-installer'

  -- LSP progress indicator
  use {
    'j-hui/fidget.nvim',
    config = function()
        require('fidget').setup()
    end
  }

  -- LSP colors
  use 'folke/lsp-colors.nvim'
  -- LSP highlight
  use 'rrethy/vim-illuminate'

  -- Code linting/diagnostics
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Code completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'

  -- Gitsigns
  use 'lewis6991/gitsigns.nvim'

  -- Dim inactive windows
  -- use 'sunjon/shade.nvim' -- buggy
  -- use 'TaDaa/vimade' -- requires python, also buggy

  -- Better commenting
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- File explorer
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
        require('nvim-tree').setup()
    end
  }

  -- Tender colorscheme
  use 'jacoborus/tender.vim'

end)
