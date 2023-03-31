local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- plugin keybinds
keymap("n", "<S-f>", ":Telescope<CR>", opts)
keymap("n", "<S-t>", ":NvimTreeToggle<CR>", opts)

-- buffers
keymap("n", "<S-n>", ":bn<CR>", opts)
keymap("n", "<S-p>", ":bp<CR>", opts)
keymap("n", "<S-x>", ":bd<CR>", opts)
keymap("n", "<S-h>", "<C-w>h", opts)
keymap("n", "<S-j>", "<C-w>j", opts)
keymap("n", "<S-k>", "<C-w>k", opts)
keymap("n", "<S-l>", "<C-w>l", opts)

-- easy keybinds for saving and quitting
keymap("n", "<S-w>", ":w<CR>", opts)
keymap("n", "<S-q>", ":q<CR>", opts)
