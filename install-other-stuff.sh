# Install Regolith, LightDM and Polybar
sudo add-apt-repository ppa:regolith-linux/stable -y
sudo apt update
sudo apt install -y \
    regolith-desktop-minimal \
    regolith-compositor-picom-glx \
    lightdm \
    slick-greeter \
    polybar \
    fonts-font-awesome \
    fonts-materialdesignicons-webfont \
    fonts-source-code-pro-ttf \
    lightdm-gtk-greeter- \
    gdm3-
sudo dpkg-reconfigure lightdm -f noninteractive
grep -qF '[SeatDefaults]' /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf \
    && grep -qF 'random' /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf \
    || sudo sh -c "echo '\n[SeatDefaults]\nuser-session=regolith' >> /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf"

# Build and install GLava
sudo apt install libgl1-mesa-dev libpulse0 libpulse-dev libxext6 libxext-dev libxrender-dev libxcomposite-dev liblua5.3-dev liblua5.3-0 lua-lgi lua-filesystem libobs0 libobs-dev meson build-essential gcc -y
sudo ldconfig
git clone https://github.com/jarcode-foss/glava
cd glava
meson build --prefix /usr
ninja -C build
sudo ninja -C build install
cd

# Build and install cli-visualizer
sudo apt install libfftw3-dev libncursesw5-dev cmake libpulse-dev -y
git clone https://github.com/dpayne/cli-visualizer
cd cli-visualizer
./install.sh
cd

# Install Spicetify
curl -fsSL https://raw.githubusercontent.com/khanhas/spicetify-cli/master/install.sh | sh
spicetify
echo -e "Once Spotify has been installed (not the snap\!) please run the following:
\tsudo chmod a+wr /usr/share/spotify
\tsudo chmod a+wr /usr/share/spotify/Apps -R
Visit https://github.com/khanhas/spicetify-cli/wiki/Basic-Usage for usage instructions"
