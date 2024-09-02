return{
	"goolord/alpha-nvim",
	event = "vimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

	dashboard.section.header.val = {
	"  							       ",	
	"  ██████╗  █████╗ ██████╗ ██╗      ██████╗  █████╗ ████████╗  ",
	"  ██╔══██╗██╔══██╗██╔══██╗██║     ██╔═══██╗██╔══██╗╚══██╔══╝  ",
	"  ██║  ██║███████║██████╔╝██║     ██║   ██║███████║   ██║     ",
	"  ██║  ██║██╔══██║██╔══██╗██║     ██║   ██║██╔══██║   ██║     ",
	"  ██████╔╝██║  ██║██████╔╝███████╗╚██████╔╝██║  ██║   ██║     ",
	"  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝     ",	
	"  		 					       "
	}

	alpha.setup(dashboard.opts)

	vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end
}
