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
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'j-morano/buffer_manager.nvim'
  use {
    'akinsho/bufferline.nvim', tag = "v3.*", 
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

  use 'projekt0n/github-nvim-theme'
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/vscode.nvim'
  use 'sainnhe/sonokai'
  use 'rafamadriz/neon'
  use 'yazeed1s/minimal.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end
end)

