return{
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-fzf-native.nvim",
          	build = "make",
          	config = function()
            		require("telescope").load_extension("fzf")
          	end,
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup(
		{
			defaults = {
			path_display = {"smart"},
			},
		})

		--telescope.load_extension("fzf")

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy Find Files"})
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find/Search for Strings"})
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cusor"})
	end
}
