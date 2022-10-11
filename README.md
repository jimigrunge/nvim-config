# JimiGrunge Neovim configuration

## Try out this config

### requirements

* `Neovim 0.7 release` version
* Ubuntu or Macos Operating system
  * Other operating systems will need manual install
* A version of bat that is compatible with OS
  * For Ubuntu 18 use `bat` version 0.19.0 download package from github
  * https://github.com/sharkdp/bat/releases/tag/v0.19.0
  * `sudo dpkg -i bat_0.19.0_amd64.deb`

### Install

Run the `nvim-install.sh` script.
This will install all dependencies, backup your existing configuration, and copy this configuration into place.


#### Then

Run `nvim` and wait for the plugins to be installed

You may need to restart neovim after initial plugin install

**NOTE** You will notice treesitter pulling in a bunch of parsers the next time you open Neovim. This is normal, just let it run.

Install plugins by running `:PackerInstall` then `:PackerCompile`

Install language packs individually by running `:LspInstall [language_name]`

Alternatively you can use the Language List interface by running `:LspInstallInfo`

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```
