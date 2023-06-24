#!/usr/bin/env bash
#
# JimiGrunge NeoVim configuration installer
#
# @author James Grundner <james@jgrundner.com>
#
# THIS IS A WORK IN PROGRESS - USE AT YOUR OWN RISK !!!
#
# ############################################################
# TODO: NerdFont install "DejaVuSansMono Nerd Font Book"
#       https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/DejaVuSansMono.zip
# TODO: Move Intelephense key file into place
# ############################################################

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
CONST_LINUX="Linux"
CONST_MAC="Darwin"
# CONST_CYGWIN="Cygwin"
# CONST_MINGW="MinGw"

NVIM_SRC_DIR=$(pwd)/config/nvim
NVIM_INSTALL_DIR=~/.config/nvim
LOCAL_BIN_DIR=~/bin
VIM_LOG_DIR=~/.log/vim
CONFIG_DIR=~/.config
DBG_ADAPTER_DIR=~/.local/share/debug-adapters
GLOBAL_NPM_DIR=~/.npm
# NVIM_BACKUP=~/.config/nvim
# BASH_PROFILE=~/.profile
# ZSH_PROFILE=~/.zshrc

# Get os type
unameOut="$(uname -s)"

echo "Installing NeoVim configuration..."
echo "OS: $unameOut"
echo "Installer dir: $NVIM_SRC_DIR"
echo "NeoVim install dir: $NVIM_INSTALL_DIR"
echo "Local bin dir: $LOCAL_BIN_DIR"


install_linux_deps()
{
    echo "OS setup begin"
    echo "Updating apt..."
    sudo apt-get update

    if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed, attempting to install.' >&2
        sudo apt install git tig -y
    fi
    if ! [ -x "$(command -v pip)" ]; then
        echo 'Error: pip is not installed, attempting to install.' >&2
        sudo apt install python3-pip -y
        pip install --upgrade pynvim
    fi
    if ! [ -x "$(command -v node)" ]; then
        echo 'Error: nodejs is not installed, attempting to install.' >&2
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | sudo bash -
        sudo apt install curl build-essential -y
        sudo apt-get install nodejs -y
    fi
    if ! [ -x "$(command -v go)" ]; then
        echo 'Error: go not found, attampting to install.' >&2
        sudo add-apt-repository ppa:longsleep/golang-backports
        sudo apt update
        sudo apt install golang-go
    fi
    if ! [ -x "$(command -v rg)" ]; then
        echo 'Error: ripgrep not found, attampting to install.' >&2
        sudo apt install ripgrep -y
    fi
    if ! [ -x "$(command -v xclip)" ]; then
        echo 'Error: xclip not found, attampting to install.' >&2
        sudo apt install xclip -y
    fi
    if ! [ -x "$(command -v fzf)" ]; then
        echo 'Error: fzf not found, attampting to install.' >&2
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi
    if ! [ -x "$(command -v php)" ]; then
        echo 'Error: php not found, attampting to install.' >&2
        sudo apt install -y php php-cli php-fpm php-json php-common php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath
    fi
    if ! [ -x "$(command -v composer)" ]; then
        echo 'Error: composer not found, attampting to install.' >&2
        install_composer
    fi
    if ! [ -x "$(command -v cargo)" ]; then
      # Pre Ubuntu 20.04
      # curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

      # On Ubuntu 20.04+ `sudo apt install rustc`
      sudo apt install -y rustc
    fi
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: jq not found, attampting to install.' >&2
        sudo apt install jq -y
    fi

    echo "OS setup complete"
}

install_mac_deps()
{
    echo "OS setup begin"

    if ! [ -x "$(command -v brew)" ]; then
        echo 'Error: MacOS requires homebrew package manager' >&2
        echo '  Attempting to install homebrew...' >&2
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    if [ -x "$(command -v brew)" ]; then
      echo 'Updating Homebrew.' >&2
      brew update
    fi
    if ! [ -x "$(command -v git)" ]; then
        echo 'Error: git is not installed, attempting to install.' >&2
        brew install git
    fi
    if ! [ -x "$(command -v pip)" ]; then
        echo 'Error: pip is not installed, attempting to install.' >&2
        brew install python
        pip install --upgrade pynvim
        pip3 install --upgrade pynvim
    fi
    if ! [ -x "$(command -v node)" ]; then
        echo 'Error: nodejs is not installed, attempting to install.' >&2
        brew install node
    fi
    if ! [ -x "$(command -v fzf)" ]; then
        echo 'Error: fzf not found, attampting to install.' >&2
        brew install fzf
        "$(brew --prefix)"/opt/fzf/install
    fi
    if ! [ -x "$(command -v rust-analyzer)" ]; then
        echo 'Error: rust not found, attampting to install.' >&2
        brew install rust
        brew install rust-analyzer
    fi
    if ! [ -x "$(command -v php)" ]; then
        echo 'Error: php not found, attampting to install.' >&2
        brew install php
    fi
    if ! [ -x "$(command -v composer)" ]; then
        echo 'Error: composer not found, attampting to install.' >&2
        install_composer
    fi
    if ! [ -x "$(command -v jq)" ]; then
        echo 'Error: jq not found, attampting to install.' >&2
        brew install jq
    fi

    echo "OS setup complete"
}

create_dirs()
{
    echo "Making sure required directories exist"
    # Create log directory if not present
    mkdir -pv $VIM_LOG_DIR
    # Create local bin
    mkdir -pv $LOCAL_BIN_DIR
    # Create step debug config directory
    mkdir -pv $CONFIG_DIR
    # Create debug adapter directory
    mkdir -pv $DBG_ADAPTER_DIR
}

# Fix for npm's global permissions issue
fix_npm_global_perms()
{
    echo "Fixing NPM permissions"
    mkdir -pv $GLOBAL_NPM_DIR
    npm config set prefix "$GLOBAL_NPM_DIR"
    export PATH=$GLOBAL_NPM_DIR/bin:$PATH

    # echo "Bash version: $BASH_VERSION"
    # if [[ -f $BASH_PROFILE ]]; then
    #     echo "Sourcing bash profile"
    #     source $BASH_PROFILE
    # fi

    # echo "Zsh version: $ZSH_VERSION"
    # if [[ -f $ZSH_PROFILE ]]; then
    #     echo "Sourcing zsh profile"
    #     source $ZSH_PROFILE
    # fi
}

# Language server installs
install_libraries()
{
    echo "Installing Libraries"

    echo "Ensuring we have NPM dependancies"
    echo "* Checking for n npm version manager"
    if ! [ -x "$(command -v n)" ]; then
        npm install -g n
    fi
    echo "* Checking for neovim bridge"
    if ! [ -x "$(command -v neovim-node-host)" ]; then
        npm install -g neovim
    fi
    echo "* Checking for typescript"
    if ! [ -x "$(command -v tsc)" ]; then
        npm install -g typescript
    fi
    echo "* Checking for prettier"
    if ! [ -x "$(command -v prettier)" ]; then
        npm install -g prettier
    fi
    echo "* Checking for eslint"
    if ! [ -x "$(command -v eslint)" ]; then
        npm install -g eslint
    fi
    echo "* Checking for eslint-d"
    if ! [ -x "$(command -v eslint_d)" ]; then
        npm install -g eslint_d
    fi

    echo "Insure we have PHP Linting and Formatting"
    echo "* Checking for php code sniffer"
    if ! [ -x "$(command -v phpcs)" ]; then
        wget https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
        mv phpcs.phar $LOCAL_BIN_DIR./phpcs

        wget https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
        mv phpcbf.phar $LOCAL_BIN_DIR./phpcbf
    fi

    echo "* Checking for php-cs-fixer"
    if ! [ -x "$(command -v php-cs-fixer)" ]; then
        wget https://cs.symfony.com/download/php-cs-fixer-v3.phar -O php-cs-fixer
        mv php-cs-fixer $LOCAL_BIN_DIR./php-cs-fixer
    fi

    echo "* Checking for php mess detector"
    if ! [ -x "$(command -v phpmd)" ]; then
        wget -c https://phpmd.org/static/latest/phpmd.phar
        mv phpmd.phar $LOCAL_BIN_DIR./phpmd
    fi

    echo "Library installs complete"
}

install_nvim_files()
{
    echo "Backing up current NeoVim configurations to $NVIM_INSTALL_DIR.$TIMESTAMP"
    if [[ -d "$NVIM_INSTALL_DIR" ]]; then
        mv -f "$NVIM_INSTALL_DIR" "$NVIM_INSTALL_DIR.$TIMESTAMP"
    fi

    echo "Copying nvim configuration into place"
    cp -r "$NVIM_SRC_DIR" "$NVIM_INSTALL_DIR"
}

install_composer()
{
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php --install-dir=$LOCAL_BIN_DIR --filename=composer
    php -r "unlink('composer-setup.php');"

    export PATH=~/.composer/vendor/bin:~/.config/composer/vendor/bin:$PATH
    echo "Composer install complete"
}

case "${unameOut}" in
    ${CONST_LINUX}*)
        echo $CONST_LINUX
        install_linux_deps
        ;;
    ${CONST_MAC}*)
        echo $CONST_MAC
        install_mac_deps
        ;;
#    CYGWIN*)    MACHINE=${CONST_CYGWIN};;
#    MINGW*)     MACHINE=${CONST_MINGW};;
    *)          MACHINE="UNKNOWN:${unameOut}"
        echo "OS ${MACHINE} Is Not Supported"
        exit 1
esac

create_dirs
fix_npm_global_perms
install_libraries
install_nvim_files

# See: https://www.reddit.com/r/neovim/comments/mohogr/neovim_lua_config_cant_install_plugins_when/
# echo "Install nvim plugins"
# nvim --headless +PackerInstall +qall

echo $"

If you require XML language support:
Download the latest binary for your system here: https://download.jboss.org/jbosstools/vscode/stable/lemminx-binary/
Set 'jvim.config.xml' to true in 'lua/init.lua'

Please run ':PackerSync' to complete plugin installation.
"

echo "NeoVim Install Complete"
exit 0
