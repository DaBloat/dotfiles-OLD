vim.wo.relativenumber = true
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
      {
     	-- Nord Themes 
	"gbprod/nord.nvim",
         lazy = false,
         priority = 1000,
   	 config = function()
     	 require("nord").setup({})
      	 vim.cmd.colorscheme("nord")
   	 end,
       },
       {
	 -- Nvim treesitter (https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file)
	 "nvim-treesitter/nvim-treesitter",
	 build = ":TSUpdate"
       },
       {
	 -- Telescope
    	 'nvim-telescope/telescope.nvim', 
	 tag = '0.1.8',
      	 dependencies = { 'nvim-lua/plenary.nvim' }
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "nord" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("telescope").setup{

  pickers = {
    find_files = {
      hidden = true
    },
  }
}

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-o>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})
