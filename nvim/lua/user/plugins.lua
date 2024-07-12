local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1', 
      'https://github.com/wbthomason/packer.nvim',
      install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'j-morano/buffer_manager.nvim'
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use 'tiagovla/scope.nvim'
  use {
  'tanvirtin/vgit.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use 'lewis6991/gitsigns.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'p00f/godbolt.nvim'
  use 'nvim-telescope/telescope-symbols.nvim'

--  use 'neovim/nvim-lspconfig'
--  use 'VonHeikemen/lsp-zero.nvim'
--  use 'williamboman/mason.nvim'
--  use 'williamboman/mason-lspconfig.nvim'
--  use 'hrsh7th/nvim-cmp'
--  use 'hrsh7th/cmp-nvim-lsp'
--  use 'L3MON4D3/LuaSnip'
--  use 'rafamadriz/friendly-snippets'

  use { "catppuccin/nvim", as = "catppuccin" }
  use 'projekt0n/github-nvim-theme'
  use 'EdenEast/nightfox.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)

