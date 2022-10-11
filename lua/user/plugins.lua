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
  use { "wbthomason/packer.nvim", commit = "d268d2e083ca0abd95a57dfbcc5d5637a615e219" }

  -- An implementation of the Popup API from vim in Neovim
  use { "nvim-lua/popup.nvim", commit = "b7404d35d5d3548a82149238289fa71f7f6de4ac" }

  -- Useful lua functions used by lots of plugins
  use { "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }

  -- Greeter window
  use { "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" }

  -- Smooth scrolling
  use {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup()
    end,
    commit = "71c8fadd60362383e5e817e95f64776f5e2737d8"
  }
  use { 'dstein64/nvim-scrollview', commit = "f8308c3c91b7879c3286554dda484bcf973df6ad" }

  -- Autopairs, integrates with both cmp and treesitter
  use { "windwp/nvim-autopairs", commit = "4a95b3982be7397cd8e1370d1a09503f9b002dbf" }
  use { "windwp/nvim-ts-autotag", commit = "044a05c4c51051326900a53ba98fddacd15fea22" }
  use { "anuvyklack/nvim-keymap-amend", commit = "4a6a62174d6c28da57ac379cf13afb418164c6f0" }
  use {
    "anuvyklack/pretty-fold.nvim",
    commit = "af4afff523fc1daee33bee32d6786c90d8bcc121",
    requires = "anuvyklack/nvim-keymap-amend", -- only for preview
  }

  -- Easily comment stuff
  use { "numToStr/Comment.nvim", commit = "4086630ce2aaf76b2652516ee3169f0b558f6be1" }

  -- Surround text
  use { "ur4ltz/surround.nvim", commit = "633068182cf894480341b992445f0f0d2883721d" }

  -- File icon
  use { "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" }
  use { "ryanoasis/vim-devicons", commit = "a2258658661e42dd4cdba4958805dbad1fe29ef4" }

  -- Sidebar directory tree
  use {
    "kyazdani42/nvim-tree.lua",
    commit = "7a795d78fa2a102de197e81b85f5b1e6b5f366a3",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
    tag = "nightly",
  }

  -- Tabs for buffers
  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    commit = "68839d62785edfb4ff7a7b3c1e9f4b64d55749e8"
  }

  -- Delete buffers without closing your window
  use { "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" }

  -- Status bar
  use {
    "nvim-lualine/lualine.nvim",
    commit = "5113cdb32f9d9588a2b56de6d1df6e33b06a554a",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  }

  -- Symbol view of document structure
  use { "simrat39/symbols-outline.nvim", commit = "15ae99c27360ab42e931be127d130611375307d5" }

  -- Terminal windows inside of Nvim
  use { "akinsho/toggleterm.nvim", commit = "04174e19196ecef43dd159b29d4e6ddb07b80909" }

  -- Project management
  use { "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" }

  -- Speed up loading Lua modules improving startup time
  use { "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" }

  -- Indentation guides
  use { "lukas-reineke/indent-blankline.nvim", commit = "4a58fe6e9854ccfe6c6b0f59abb7cb8301e23025" }

  -- This is needed to fix lsp doc highlight
  use { "antoinemadec/FixCursorHold.nvim", commit = "1bfb32e7ba1344925ad815cb0d7f901dbc0ff7c1" }

  -- Keymap cheatsheet
  use { "folke/which-key.nvim", commit = "bd4411a2ed4dd8bb69c125e339d837028a6eea71" }

  -- Colorschemes
  use { "arcticicestudio/nord-vim", commit = "bc0f057162491e9228207d74bd88b5efe875316e" }
  use { "dracula/vim", commit = "d7723a842a6cfa2f62cf85530ab66eb418521dc2" }
  use { "rmehri01/onenord.nvim", commit = "eaa5baec341a0b9dcf3621d886d77f4539f8a3c1" }
  use { "shaunsingh/moonlight.nvim", commit = "e24e4218ec680b6396532808abf57ca0ada82e66" }
  use { "lunarvim/darkplus.nvim", commit = "fe67a1a1663e65ac4fbd3e9a18874d6990a4f6e5" }
  use { "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" }
  use {
    "Mofiqul/vscode.nvim",
    commit = "ba65e6ad9a486737dcd912a1ae58b940e2b38a5c",
    config = function()
      require('vscode').change_style("dark")
    end
  }
  use { "lunarvim/colorschemes", commit = "2ddcd2a552583c1ca3659910b44c07c52778a0a6" }

  -- cmp Completion plugins
  use { "hrsh7th/nvim-cmp", commit = "9897465a7663997b7b42372164ffc3635321a2fe" }
  use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }
  use { "hrsh7th/cmp-path", commit = "981baf9525257ac3269e1b6701e376d6fbff6921" }
  use { "hrsh7th/cmp-cmdline", commit = "c36ca4bc1dedb12b4ba6546b96c43896fd6e7252" }
  use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }
  use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- Snippets
  use { "L3MON4D3/LuaSnip", commit = "a12441e0598e93e67235eba67c8e6fbffc896f06" }
  use { "rafamadriz/friendly-snippets", commit = "471f3ab20c1ee02d33830f379caaa8edfbd39808" }
  use { "Pocco81/AbbrevMan.nvim", commit = "97b40b51b373d0d1c22f71dd8fce7f61f6bf46a5" }

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "057ca6b7f5312f323eb7212f9282ed723560bc3f" }
  use { "williamboman/nvim-lsp-installer", commit = "c13ea61d85e2170af35c06b47bcba143cf2f244b" }
  use { "tamago324/nlsp-settings.nvim", commit = "5e9c189ec5180a498aee7e1c4aa83195108ae16f" }
  use { "jose-elias-alvarez/null-ls.nvim", commit = "a2b7bf89663c78d58a5494efbb791819a24bb025" }
  use { "RishabhRD/popfix", commit = "ea262861ce3905b90c2c203b74a7be2539f1aba4" }
  use { "RishabhRD/nvim-lsputils", commit = "ae1a4a62449863ad82c70713d5b6108f3a07917c" }
  use { "ray-x/lsp_signature.nvim", commit = "6c65bc81dd041e7f4e49662bb8fb54cacc66efad" }
  use { "kosayoda/nvim-lightbulb", commit = "1e2844b68a07d3e7ad9e6cc9a2aebc347488ec1b" }
  use {
    "weilbith/nvim-code-action-menu",
    commit = "ee599409ed6ab31f6d7115e9c5c4550336470c14",
    cmd = 'CodeActionMenu',
  }
  use {
    "SmiteshP/nvim-navic",
    commit = "250d89085a69688157864201b533ee0581eb6a83",
    requires = "neovim/nvim-lspconfig"
  }
  use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }
  use { "MunifTanjim/nui.nvim", commit = "1afa3982c37738bc0bace238e917d96d1e6ad788" }
  use {
    "CosmicNvim/cosmic-ui",
    commit = "d0445a5df703207b700151fb87537ac4bc3f962f",
    requires = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  }

  -- Diagnostics
  use { "creativenull/diagnosticls-configs-nvim", commit = "03da04c4dd736a25a4d8e19a5fadb95ce9202905" }
  use {
    "folke/trouble.nvim",
    commit = "da61737d860ddc12f78e638152834487eabf0ee5",
    cmd = "TroubleToggle",
  }
  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    commit = "db67e94c813aae166c3d2f119ea7d2e85164922a",
    config = function()
      require("lsp_lines").setup()
    end,
  })

  -- Whitespace
  use { "ntpeters/vim-better-whitespace", commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d" }

  -- Telescope
  use { "junegunn/fzf", commit = "885cd8ff04e73d61279f0ac58011f74613e809dd" }
  use { 'nvim-telescope/telescope-fzf-native.nvim', commit = "6a33ecefa9b3d9ade654f9a7a6396a00c3758ca6", run = 'make' }
  -- use { "nvim-telescope/telescope.nvim", commit = "b98b9a93c67cb999493ccdc602e711c8a7a98d64" }
  use { "nvim-telescope/telescope.nvim", branch = '0.1.x' }
  use { "nvim-telescope/telescope-media-files.nvim", commit = "513e4ee385edd72bf0b35a217b7e39f84b6fe93c" }

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    commit = "3b1ce2e1b30b731c80753fa9bbcb2cfec38a43da",
    run = ":TSUpdate",
  }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }
  use { "nvim-treesitter/nvim-treesitter-textobjects", commit = "c8a393ecb6251d15e76dce8d8da522062090497d" }
  use { "nvim-treesitter/playground", commit = "ce7e4b757598f1c785ed0fd94fc65959acd7d39c" }
  use { "ThePrimeagen/refactoring.nvim", commit = "f7167900ff3835bb43d279152dc4b83e941b1b55" }
  use { "danymat/neogen", commit = "c5a0c39753808faa41dea009d41dd686732c6774" }
  use { 'nvim-treesitter/nvim-treesitter-context', commit = "8e88b67d0dc386d6ba1b3d09c206f19a50bc0625" }

  -- Git
  use { "lewis6991/gitsigns.nvim", commit = "4883988cf8b623f63cc8c7d3f11b18b7e81f06ff" }
  use { "tpope/vim-fugitive", commit = "8fd6bad4a4dfbad85d57d03e5ba12a00effbfe8c" }
  use {
    "sindrets/diffview.nvim",
    commit = "a1ab9602ee1d4c78e81bc6032edca6df480aa296",
    event = "BufRead",
    requires = "nvim-lua/plenary.nvim"
  }

  -- Color preview/picker
  use { "norcalli/nvim-colorizer.lua", commit = "36c610a9717cc9ec426a07c8e6bf3b3abcb139d6" }
  use {
    "ziontee113/color-picker.nvim",
    commit = "c253206980696e258f508f4e5b000b0391a1d01d",
    config = function()
      require("color-picker")
    end,
  }
  use {
    "stevearc/dressing.nvim",
    commit = "d886a1bb0b43a81af58e0331fedbe8b02ac414fa"
  }
  use({
    "ziontee113/icon-picker.nvim",
    commit = "045914d00daf27eb7a38816bd229fd2d70598302",
    config = function()
      require("icon-picker")
    end,
  })

  -- Markdown preview
  use {
    "ellisonleao/glow.nvim",
    run = ":GlowInstall",
    branch = "main",
    commit = "900042f7dda528cb980b7f1056ed7c21d4402826",
    opt = false,
    ft = { "markdown" },
    config = function()
      require("user.glow")
    end
  }
  -- Popup notifications
  use { "rcarriga/nvim-notify", commit = "7caeaaef257ecbe95473ec79e5a82757b544f1fd" }
  use { "j-hui/fidget.nvim", commit = "46d1110435f1f023c22fa95bb10b3906aecd7bde" }

  -- Searchable cheatsheet using Telescope
  use { "sudormrfbin/cheatsheet.nvim", commit = "9716f9aaa94dd1fd6ce59b5aae0e5f25e2a463ef" }

  -- DAP debug adapter
  use { "mfussenegger/nvim-dap", commit = "f4a3be57f61893cffa1e22aa5e1e7bded495fcf2" }
  use { "rcarriga/nvim-dap-ui", commit = "b0bc932ce6ca57bdec5536d773ab643e5b2f57ad" }
  use { "theHamsta/nvim-dap-virtual-text", commit = "a36982259216afd710f55bcdc220477c74b5bc35" }
  use { "nvim-telescope/telescope-dap.nvim", commit = "b4134fff5cbaf3b876e6011212ed60646e56f060" }
  -- DAP language packs
  use { "mfussenegger/nvim-dap-python", commit = "de1fa39d3a101b2c9bc548eceef735791ecccc40" }
  use { "mfussenegger/nvim-jdtls", commit = "703268d5b8479de4e0c27af93b203d56c1b53d2b" }
  -- These are a bit buggy yet for some languages. Waiting for updates
  -- use { "ravenxrz/DAPInstall.nvim", commit = "8798b4c36d33723e7bba6ed6e2c202f84bb300de" }
  -- use { "Pocco81/DAPInstall.nvim", commit = "24923c3819a450a772bb8f675926d530e829665f" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
