local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  max_jobs = 10,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Have packer manage itself
  use { "wbthomason/packer.nvim" }

  -- An implementation of the Popup API from vim in Neovim
  use { "nvim-lua/popup.nvim"
    ,commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac"
  }

  -- Useful lua functions used by lots of plugins
  use { "nvim-lua/plenary.nvim"
    ,commit = "4b7e52044bbb84242158d977a50c4cbcd85070c7"
  }

  -- Greeter window
  use { "goolord/alpha-nvim"
    ,commit = "0bb6fc0646bcd1cdb4639737a1cee8d6e08bcc31"
  }

  -- Smooth scrolling
  use {
    "karb94/neoscroll.nvim",
    commit = "54c5c419f6ee2b35557b3a6a7d631724234ba97a",
    config = function()
      require('neoscroll').setup()
    end
  }
  use { "dstein64/nvim-scrollview"
    ,commit = "25c23219db8b2b932a595b4d2b661406ce4459fe"
  }

  -- Navigation between vim and tmux
  use {
    "christoomey/vim-tmux-navigator"
    ,commit = "bd4c38be5b4882991494cf77c0601a55bc45eebf"
  }

  -- Autopairs, integrates with both cmp and treesitter
  use { "windwp/nvim-autopairs"
    ,commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347"
  }
  use { "windwp/nvim-ts-autotag"
    ,commit = "fdefe46c6807441460f11f11a167a2baf8e4534b"
  }

  -- Amend keymap method calls
  use { "anuvyklack/nvim-keymap-amend"
    ,commit = "b8bf9d820878d5497fdd11d6de55dea82872d98e"
  }

  -- Code folding
  use { "anuvyklack/fold-preview.nvim"
    ,commit = "0cabe8af16c73c2e0cbd9f99e0ec2b993457030c"
  }
  use { "anuvyklack/pretty-fold.nvim"
    ,commit = "a7d8b424abe0eedf50116c460fbe6dfd5783b1d5"
  }

  -- Easily comment stuff
  use { "numToStr/Comment.nvim"
    ,commit = "d30f2b059c0c03fcfab3842684212bac525a3d0b"
  }

  -- Surround text
  use { "ur4ltz/surround.nvim"
    ,commit = "633068182cf894480341b992445f0f0d2883721d"
  }

  -- File icons
  use { "kyazdani42/nvim-web-devicons"
    ,commit = "a8cf88cbdb5c58e2b658e179c4b2aa997479b3da"
  }
  use { "ryanoasis/vim-devicons"
    ,commit = "71f239af28b7214eebb60d4ea5bd040291fb7e33"
  }

  -- Sidebar directory tree
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "7282f7de8aedf861fe0162a559fc2b214383c51c",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    --[[ tag = "nightly", ]]
  }

  -- Tabs for buffers
  use {
    "akinsho/bufferline.nvim",
    commit = "5aa803aaa9d8bbbca77d0c8df8ddc0b62c19ff6a",
    tag = "v2.*"
  }

  -- Delete buffers without closing your window
  use { "moll/vim-bbye"
    ,commit = "25ef93ac5a87526111f43e5110675032dbcacf56"
  }

  -- Status bar
  use {
    "nvim-lualine/lualine.nvim",
    commit = "edca2b03c724f22bdc310eee1587b1523f31ec7c",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }

  -- Symbol view of document structure
  use { "simrat39/symbols-outline.nvim"
    ,commit = "6a3ed24c5631da7a5d418bced57c16b32af7747c"
  }

  -- Terminal windows inside of Nvim
  use { "akinsho/toggleterm.nvim"
    ,commit = "2a787c426ef00cb3488c11b14f5dcf892bbd0bda"
  }

  -- Project management
  use { "ahmedkhalf/project.nvim"
    ,commit = "628de7e433dd503e782831fe150bb750e56e55d6"
  }

  -- Speed up loading Lua modules improving startup time
  use { "lewis6991/impatient.nvim"
    ,commit = "b842e16ecc1a700f62adb9802f8355b99b52a5a6"
  }

  -- Indentation guides
  use { "lukas-reineke/indent-blankline.nvim"
    ,commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6"
  }

  -- This is needed to fix lsp doc highlight
  use { "antoinemadec/FixCursorHold.nvim"
    ,commit = "70a9516a64668cbfe59f31b66d0a21678c5e9b12"
  }

  -- Keymap cheatsheet
  use { "folke/which-key.nvim"
    ,commit = "6885b669523ff4238de99a7c653d47b081b5506d"
  }

  -- Colorschemes
  use { "arcticicestudio/nord-vim"
    ,commit = "0748955e9e8d9770b44f2bec8456189430b37d9d"
  }
  use { "dracula/vim"
    ,commit = "834f54c1e09a4ae7115f590ad26d470ccd67c3b4"
  }
  use { "rmehri01/onenord.nvim"
    ,commit = "749ee2f7fdeb9a02f25195d4850d2ff16240c863"
  }
  use { "shaunsingh/moonlight.nvim"
    ,commit = "e24e4218ec680b6396532808abf57ca0ada82e66"
  }
  use { "lunarvim/darkplus.nvim"
    ,commit = "7a618c4fc76319ecad67b8dfa484af981bd931ca"
  }
  use { "folke/tokyonight.nvim"
    ,commit = "fd9105c9487996aa2269992b72a6fea7504688e4"
  }
  use {
    "Mofiqul/vscode.nvim",
    commit = "c5125820a0915ef50f03fae10423c43dc49c66b1",
    --[[ config = function() ]]
    --[[   require('vscode').change_style("dark") ]]
    --[[ end ]]
  }
  use { "lunarvim/colorschemes"
    ,commit = "fd08d338645aa7044e5b80379c33e33a4befbc1c"
  }

  -- cmp Completion plugins
  use { "hrsh7th/nvim-cmp",
    commit = "0e436ee23abc6c3fe5f3600145d2a413703e7272"
  }
  use { "hrsh7th/cmp-buffer",
    commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa"
  }
  use { "hrsh7th/cmp-path",
    commit = "91ff86cd9c29299a64f968ebb45846c485725f23"
  }
  use { "hrsh7th/cmp-cmdline",
    commit = "c66c379915d68fb52ad5ad1195cdd4265a95ef1e"
  }
  use { "saadparwaiz1/cmp_luasnip",
    commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36"
  }
  use { "hrsh7th/cmp-nvim-lsp",
    commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8"
  }
  use { "hrsh7th/cmp-nvim-lua",
    commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21"
  }

  -- Snippets
  use { "L3MON4D3/LuaSnip",
    commit = "aa7acef98392f35288590f2fcf984b19e0d5bc29"
  }
  use { "rafamadriz/friendly-snippets",
    commit = "6cd7469403fd06a3840a1065728d1affe1c23ec8"
  }
  use { "Pocco81/AbbrevMan.nvim",
    commit = "97b40b51b373d0d1c22f71dd8fce7f61f6bf46a5"
  }

  -- LSP
  use { "neovim/nvim-lspconfig",
    commit = "0a8064eda0c7a4475c4a8ceb39199e975308797b"
  }
  use { "williamboman/mason.nvim",
    commit = "d06095e26375fde04134adab2f2f5372e93d5dd8"
  }
  use { "williamboman/mason-lspconfig.nvim",
    commit = "0eb7cfefbd3a87308c1875c05c3f3abac22d367c"
  }
  use { "tamago324/nlsp-settings.nvim",
    commit = "ba69c09ab13621d291adaf00b2ccb5b68e6a7a09"
  }
  use { "jose-elias-alvarez/null-ls.nvim",
    commit = "355f7012b4afd92c0387770f1bea892e74a91b2e"
  }
  use { "jayp0521/mason-null-ls.nvim"
    , commit = "7a8411c99010314cc2aa23521aac4b3a657f137e"
  }
  use { "RishabhRD/popfix",
    commit = "bf3cc436df63cd535350d5ef1b951c91554d4b01"
  }
  use { "RishabhRD/nvim-lsputils",
    commit = "ae1a4a62449863ad82c70713d5b6108f3a07917c"
  }
  use { "ray-x/lsp_signature.nvim",
    commit = "e65a63858771db3f086c8d904ff5f80705fd962b"
  }
  use { "kosayoda/nvim-lightbulb",
    commit = "56b9ce31ec9d09d560fe8787c0920f76bc208297"
  }
  use {
    "weilbith/nvim-code-action-menu",
    commit = "58e12501ea028ff1171f8f06ea53891f7c6e1c3f",
    cmd = 'CodeActionMenu',
  }
  use {
    "SmiteshP/nvim-navic",
    commit = "132b273773768b36e9ecab2138b82234a9faf5ed",
    requires = "neovim/nvim-lspconfig"
  }
  use { "RRethy/vim-illuminate",
    commit = "0603e75fc4ecde1ee5a1b2fc8106ed6704f34d14"
  }
  use { "MunifTanjim/nui.nvim",
    commit = "4715f6092443f0b8fb9a3bcb0cfd03202bb03477"
  }
  use {
    "CosmicNvim/cosmic-ui",
    commit = "d0445a5df703207b700151fb87537ac4bc3f962f",
    requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  }

  -- Diagnostics
  use { "creativenull/diagnosticls-configs-nvim",
    commit = "5be7e28a984f6cc25af264853fcd527b227f4ebd"
  }
  use {
    "folke/trouble.nvim",
    commit = "929315ea5f146f1ce0e784c76c943ece6f36d786",
    cmd = "TroubleToggle",
  }
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    commit = "dbfd8e96ec2696e1ceedcd23fd70e842256e3dea",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -- Whitespace
  use { "ntpeters/vim-better-whitespace",
    commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d"
  }

  -- Telescope
  use { "junegunn/fzf",
    commit = "07da058eae6f26de4cbe08c48563154e775f6183"
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim'
    ,run = 'make'
    ,commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90"
  }
  use { "nvim-telescope/telescope.nvim",
    commit = "0b1c41ad8052badca6e72eafa4bc5481152e483e",
    branch = '0.1.x',
  }
  use { "nvim-telescope/telescope-media-files.nvim",
    commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c"
  }
  use {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
    commit = "530eb3a896e9eef270f00f4baafa102361afc93b"
  }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "8e763332b7bf7b3a426fd8707b7f5aa85823a5ac",
    run = ":TSUpdate",
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring",
    commit = "4d3a68c41a53add8804f471fcc49bb398fe8de08"
  }
  use { "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "80a38f9408102693539f54eef3e6a57d44c6147d"
  }
  use { "nvim-treesitter/playground",
    commit = "e6a0bfaf9b5e36e3a327a1ae9a44a989eae472cf"
  }
  use { "ThePrimeagen/refactoring.nvim",
    commit = "c9ca8e3bbf7218101f16e6a03b15bf72b99b2cae"
  }
  use { "danymat/neogen",
    commit = "967b280d7d7ade52d97d06e868ec4d9a0bc59282"
  }
  use { "nvim-treesitter/nvim-treesitter-context",
    commit = "c46a8a0a60412a8fe43aa6bd3a01845c46de6bf2"
  }

  -- Git
  use { "lewis6991/gitsigns.nvim",
    commit = "9787c94178b4062f30d2f06b6d52984217196647"
  }
  use { "tpope/vim-fugitive",
    commit = "dd8107cabf5fe85df94d5eedcae52415e543f208"
  }
  use {
    "sindrets/diffview.nvim",
    commit = "a1fbcaa7e1e154cfa793ab44da4a6eb0ae15458d",
    event = "BufRead",
    requires = "nvim-lua/plenary.nvim"
  }

  -- Color preview/picker
  use { "norcalli/nvim-colorizer.lua",
    commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6"
  }
  use {
    "ziontee113/color-picker.nvim",
    commit = "2b4a4a408278271909e3eb13fe0715f856c7b4d8",
    config = function()
      require("color-picker")
    end,
  }
  use {
    "stevearc/dressing.nvim",
    commit = "12b808a6867e8c38015488ad6cee4e3d58174182",
  }
  use({
    "ziontee113/icon-picker.nvim",
    commit = "0f3b2648f6f8e788bc8dfe37bc9bb18b565cfc3c",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true
      })
    end,
  })

  -- Markdown preview
  use {
    "ellisonleao/glow.nvim",
    run = ":GlowInstall",
    commit = "9038d7cdd76a930973b6158d800c8dbc02236a4b",
    branch = "main",
    opt = false,
    ft = { "markdown" },
    config = function()
      require("user.glow")
    end
  }
  -- Popup notifications
  use { "rcarriga/nvim-notify"
    ,commit = "354e0ebb269d9e4feca073372431e8453f5f262a"
  }

  -- Display processing progress
  use { "j-hui/fidget.nvim",
    commit = "1097a86db8ba38e390850dc4035a03ed234a4673"
  }

  -- Searchable cheatsheet using Telescope
  use { "sudormrfbin/cheatsheet.nvim",
    commit = "9716f9aaa94dd1fd6ce59b5aae0e5f25e2a463ef"
  }

  -- DAP debug adapter
  use { "mfussenegger/nvim-dap",
    commit = "6b12294a57001d994022df8acbe2ef7327d30587"
  }
  use { "rcarriga/nvim-dap-ui",
    commit = "1cd4764221c91686dcf4d6b62d7a7b2d112e0b13"
  }
  use { "mxsdev/nvim-dap-vscode-js", requires = {"mfussenegger/nvim-dap"} }
  -- Removed in favor of Mason
  --[[ use { "ravenxrz/DAPInstall.nvim", ]]
  --[[   commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" ]]
  --[[ } ]]
  --[[ use { "theHamsta/nvim-dap-virtual-text" } ]]
  --[[ use { "nvim-telescope/telescope-dap.nvim" } ]]

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
