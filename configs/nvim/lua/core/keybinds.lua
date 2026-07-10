-- Global Leader
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>nh", "<cmd>noh<CR>", {desc= "Clear Search Highlights"})
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", {desc= "Close the current open buffer"})
vim.keymap.set("n", "<leader>bl", "<cmd>bn<CR>", {desc= "Move to next open buffer"})
vim.keymap.set("n", "<leader>bh", "<cmd>bp<CR>", {desc= "Move to previous open buffer"})
vim.keymap.set("n", "<leader>lg", "<cmd>LazyGit<CR>", {desc= "Open/Execute the lazygit plugin"})

-- Increment/Decrement Number under the cursor
vim.keymap.set("n", "<leader>=", "<C-a>", {desc = "Increment Number"})
vim.keymap.set("n", "<leader>-", "<C-x>", {desc = "Decrement Number"})

-- NeoTree keymaps
vim.keymap.set("n", "<leader>t", "<cmd>Neotree<CR>", {desc = "Open ups the Neotree"})

-- Telescope keymaps
vim.keymap.set('n', '<leader>ff',"<cmd>Telescope find_files<CR>", { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg',"<cmd>Telescope live_grep<CR>", { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fs',"<cmd>Telescope grep_string<CR>", { desc = 'Strings under cursor[Telescope grep_strings]' })
vim.keymap.set('n', '<leader>fb',"<cmd>Telescope buffers<CR>", { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fo',"<cmd>Telescope oldfiles<CR>", { desc = 'Telescope recent files' })

-- Auto-session keymaps
vim.keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore Sessions "})
vim.keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save Session"})
