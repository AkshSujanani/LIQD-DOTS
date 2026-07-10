return {
    "goolord/alpha-nvim",
	event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			[[ $$\       $$$$$$\  $$$$$$\  $$$$$$$\  $$\    $$\ $$$$$$\ $$\      $$\  ]],
			[[ $$ |      \_$$  _|$$  __$$\ $$  __$$\ $$ |   $$ |\_$$  _|$$$\    $$$ | ]],
			[[ $$ |        $$ |  $$ /  $$ |$$ |  $$ |$$ |   $$ |  $$ |  $$$$\  $$$$ | ]],
			[[ $$ |        $$ |  $$ |  $$ |$$ |  $$ |\$$\  $$  |  $$ |  $$\$$\$$ $$ | ]],
			[[ $$ |        $$ |  $$ |  $$ |$$ |  $$ | \$$\$$  /   $$ |  $$ \$$$  $$ | ]],
			[[ $$ |        $$ |  $$ $$\$$ |$$ |  $$ |  \$$$  /    $$ |  $$ |\$  /$$ | ]],
			[[ $$$$$$$$\ $$$$$$\ \$$$$$$ / $$$$$$$  |   \$  /   $$$$$$\ $$ | \_/ $$ | ]],
			[[ \________|\______| \___$$$\ \_______/     \_/    \______|\__|     \__| ]],
			[[ 					   \___|                                              ]],
		}

		dashboard.section.buttons.val = {
			dashboard.button( "e", " => NEW FILE", "<cmd>ene<CR>" ),
			dashboard.button( "SPC + t", "  => FILE TREE", "<cmd>Neotree<CR>" ),
			dashboard.button( "SPC + ff", "󰈞 => FIND FILE", "<cmd>Telescope find_files<CR>" ),
			dashboard.button( "SPC + fo", "󰙰 => RECENT FILES", "<cmd>Telescope oldfiles<CR>" ),
			dashboard.button( "q", "󰅙 => QUIT!!!", "<cmd>qa<CR>" ),
		}

		alpha.setup(dashboard.opts)
    end,
}
