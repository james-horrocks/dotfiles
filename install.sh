#!/bin/sh

cd

sudo apt update

# Install ZSH and Oh My ZSH
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark -O ~/.dircolors
sudo apt install git zsh curl -y
sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sudo git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
sudo git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo git clone https://github.com/sirhc/op.plugin.zsh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/op
mkdir ~/.oh-my-zsh/functions
#sudo chsh -s $(which zsh)

# Install or build Alacritty
sudo apt install alacritty || wget -O - https://raw.githubusercontent.com/james-horrocks/dotfiles/main/install-alacritty.sh | bash

# Install chezmoi for dotfile management and apply dotfiles
curl -sfL https://git.io/chezmoi | sh
~/bin/chezmoi init --apply https://github.com/james-horrocks/dotfiles

sudo apt update && sudo apt upgrade -y
sudo apt autoremove -y
sudo chsh -s $(which zsh)
