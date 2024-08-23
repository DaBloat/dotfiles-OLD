return {
 	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvim_tree = require("nvim-tree")
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.opt.termguicolors = true

		nvim_tree.setup(
		{
		  sort = {
    			   sorter = "case_sensitive",
  			 },
  		  view = {
    			   width = 30,
 			 },
   		  renderer = {
    			   group_empty = true,
			   indent_markers = { enable = true},
			   icons = { glyphs = { folder = {arrow_closed = "", arrow_open = ""} } }
  			     },
  		  filters = {
    			   dotfiles = true,
 			    },
		  actions = { open_file = { window_picker = { enable = false } } },
		})

	local keymap = vim.keymap

	keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer"})
	keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle File Explorer (Current directory)"})
	keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse/Close File Explorer"})
	keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh File Explorer"})
	end

}
