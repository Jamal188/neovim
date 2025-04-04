-- Basic settings
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Relative line numbers
vim.opt.tabstop = 4            -- Number of spaces tabs count for
vim.opt.shiftwidth = 4         -- Number of spaces to use for autoindent
vim.opt.expandtab = true       -- Convert tabs to spaces
vim.opt.smartindent = true     -- Smart autoindenting
vim.opt.mouse = 'a'            -- Enable mouse support
vim.opt.ignorecase = true      -- Case-insensitive search
vim.opt.smartcase = true       -- Case-sensitive when uppercase present

-- Plugin management with lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", 
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- File navigation
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },  -- Fuzzy finder
    'nvim-tree/nvim-tree.lua',          -- File tree explorer
    
    -- Syntax highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },  -- Better syntax highlighting
    
    -- Status line
    'nvim-lualine/lualine.nvim',        -- Fancy status line
})

-- Telescope (fuzzy finder) setup
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Nvim-tree (file explorer) setup
require("nvim-tree").setup()
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')

-- Treesitter configuration
require('nvim-treesitter.configs').setup({
    ensure_installed = {
        'python', 'html', 'css', 'javascript', 
        'json', 'lua', 'vim', 'vimdoc'
    },
    sync_install = false,
    auto_install = true,
    highlight = { enable = true },
})

-- Lualine setup
require('lualine').setup({
    options = { theme = 'auto' }
})

-- Set leader key to space
vim.g.mapleader = ' '

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

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

