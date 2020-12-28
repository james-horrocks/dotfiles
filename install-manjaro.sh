#!/bin/sh

# This script is based on a Manjaro Architect install configured to use i3,lightdm and zsh

cd

# Install and configure Oh My ZSH
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark -O ~/.dircolors
sudo pacman -Syu --noconfirm git curl
sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sudo git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
sudo git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
mkdir ~/.oh-my-zsh/functions
#sudo chsh -s $(which zsh)

# Install Polybar and slick-greeter for LightDM
sudo pacman -Syu --noconfirm \
    slick-greeter \
    polybar \
    fonts-font-awesome \
    fonts-materialdesignicons-webfont \
    fonts-source-code-pro-ttf

# Build and install Alacritty
git clone https://github.com/alacritty/alacritty.git
cd alacritty
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
~/.cargo/bin/rustup override set stable
~/.cargo/bin/rustup update stable
sudo pacman -Syu --noconfirm cmake freetype2 fontconfig pkg-config make libxcb
~/.cargo/bin/cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
cd

# Build and install GLava
sudo pacman -Syu --noconfirm glava

# Build and install cli-visualizer
sudo pamac install cli-visualizer

# Install Spicetify
curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh
spicetify
echo -e "Once Spotify has been installed (not the snap\!) please run the following:
\tsudo chmod a+wr /usr/share/spotify
\tsudo chmod a+wr /usr/share/spotify/Apps -R
Visit https://github.com/khanhas/spicetify-cli/wiki/Basic-Usage for usage instructions"

# Install chezmoi for dotfile management and apply dotfiles
sudo pacman -Syu --noconfirm chezmoi && chezmoi init --apply https://github.com/james-horrocks/dotfiles
