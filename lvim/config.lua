vim.wo.signcolumn = 'yes'
local opt = vim.opt

--opt.expandtab = false
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = false
opt.smartcase = false
opt.autoindent = true
opt.ignorecase = true
opt.mouse = "a"
opt.number = true
opt.termguicolors = true
opt.cursorline = true
opt.guicursor = "i:block"
opt.linebreak = true
opt.updatetime = 300
opt.incsearch = false
opt.wrap = false
opt.linebreak = true
opt.laststatus = 3

local opts = { noremap=false, silent = true }
local keymap = vim.api.nvim_set_keymap

-- buffers
keymap("n", "<S-n>", ":bn<CR>", opts)
keymap("n", "<S-p>", ":bp<CR>", opts)
keymap("n", "<S-x>", ":bd<CR>", opts)
keymap("n", "<S-Left>", "<C-w>h", opts)
keymap("n", "<S-Down>", "<C-w>j", opts)
keymap("n", "<S-Up>", "<C-w>k", opts)
keymap("n", "<S-Right>", "<C-w>l", opts)

keymap("n", "<S-f>", ":Telescope<CR>", opts)
keymap("n", "<S-s>", ":Gitsigns<CR>", opts)
keymap("n", "<S-t>", ":NvimTreeToggle<CR>", opts)

-- lvim config
lvim.leader = "l"
lvim.keys.normal_mode["<C-Left>"] = false
lvim.keys.normal_mode["<C-Right>"] = false
lvim.keys.normal_mode["<C-Up>"] = false
lvim.keys.normal_mode["<C-Down>"] = false
lvim.keys.normal_mode["<Tab>"] = false
lvim.log_level = "warn"
lvim.format_on_save = false
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.indent = false
lvim.builtin.cmp.active = true

lvim.plugins = {
  { "folke/tokyonight.nvim" },
  { "catppuccin/nvim" },
  { "norcalli/nvim-colorizer.lua" },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      mappings = {
        auto_set_keymaps = true,
        auto_set_highlight_group = true,
        auto_apply_diff_after_generation = true,
      },
      behaviour = {},
      windows = {
        position = "bottom"
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}
lvim.colorscheme = "catppuccin-mocha"
lvim.builtin.autopairs.active = false
lvim.builtin.indentlines.active = true
lvim.builtin.alpha.active = false
lvim.builtin.cmp.active = false


-- stupid fucking cmp comment newline christ

vim.diagnostic.config({
  virtual_text=false,
  signs = false,
  underline = false
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    callback = function()
        vim.opt_local.formatoptions:remove('c')
        vim.opt_local.formatoptions:remove('r')
        vim.opt_local.formatoptions:remove('o')
    end,
})

vim.list_extend(lvim.lsp.automatic_configuration.skipped_filetypes, {
  "make"
})

