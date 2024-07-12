local opts = { noremap=false, silent = true }
local term_opts = { noremap=false, silent = true }
local keymap = vim.api.nvim_set_keymap

-- plugin keybinds
keymap("n", "<S-f>", ":Telescope<CR>", opts)
keymap("n", "<S-t>", ":NvimTreeToggle<CR>", opts)

-- buffers
keymap("n", "<S-n>", ":bn<CR>", opts)
keymap("n", "<S-p>", ":bp<CR>", opts)
keymap("n", "<S-x>", ":bd<CR>", opts)
keymap("n", "<S-Left>", "<C-w>h", opts)
keymap("n", "<S-Down>", "<C-w>j", opts)
keymap("n", "<S-Up>", "<C-w>k", opts)
keymap("n", "<S-Right>", "<C-w>l", opts)

-- easy keybinds for saving and quitting
keymap("n", "<S-w>", ":w<CR>", opts)
keymap("n", "<S-q>", ":q<CR>", opts)

