-- Creating a local variable for "vim.opt"
local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.clipboard = "unnamedplus"
opt.wildmenu = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.smartindent = true 

opt.wrap = false				-- When off lines will not wrap and only part of long lines will be displayed.

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes:1"		--Forces the sign column to be exactly N columns wide (where N is a number from 1 to 9

-- Split windows
opt.splitright = true			-- Vertical windows will always split to the right
opt.splitbelow = true 			-- Horizontal windows always to the bottom
