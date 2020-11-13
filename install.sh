#!/bin/sh

cd

sudo apt update

# Install ZSH and Oh My ZSH
wget https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark -O ~/.dircolors
sudo apt install git zsh -y
sh -c "$(wget -qO- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
sudo git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z
sudo git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
sudo git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
mkdir ~/.oh-my-zsh/functions
#sudo chsh -s $(which zsh)

# Install LightDM
sudo apt purge gdm3 -y
sudo apt install lightdm -y
sudo dpkg-reconfigure lightdm -f noninteractive
grep -qF '[SeatDefaults]' /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf \
    && grep -qF 'random' /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf \
    || sudo sh -c "echo '\n[SeatDefaults]\nuser-session=regolith' >> /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf"

# Install Regolith and Polybar
sudo add-apt-repository ppa:regolith-linux/stable -y
sudo apt update
sudo apt install -y \
    regolith-desktop-minimal \
    regolith-compositor-picom-glx \
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
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3 gzip -y
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
sudo apt install libgl1-mesa-dev libpulse0 libpulse-dev libxext6 libxext-dev libxrender-dev libxcomposite-dev liblua5.3-dev liblua5.3 lua-lgi lua-filesystem libobs0 libobs-dev meson build-essential gcc -y
sudo ldconfig
git clone https://github.com/jarcode-foss/glava
cd glava
meson build --prefix /usr
ninja -C build
sudo ninja -C build install
cd

# Build and install cli-visualizer
sudo apt install fftw ncursesw libfftw3-dev libncursesw5-dev cmake libpulse-dev -y
git clone https://github.com/dpayne/cli-visualizer
cd cli-visualizer
./install.sh
make ENABLE_PULSE=1
cd

# Install Spicetify
curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh
spicetify
echo -e "Once Spotify has been installed (not the snap\!) please run the following:
\tsudo chmod a+wr /usr/share/spotify
\tsudo chmod a+wr /usr/share/spotify/Apps -R
Visit https://github.com/khanhas/spicetify-cli/wiki/Basic-Usage for usage instructions"

# Install chezmoi for dotfile management and apply dotfiles
curl -sfL https://git.io/chezmoi | sh
~/bin/chezmoi init --apply https://github.com/james-horrocks/dotfiles
