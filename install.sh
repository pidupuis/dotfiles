## DEACTIVATE SCREEN SAVER
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
gsettings set org.gnome.desktop.session idle-delay 0

## INSTALL APT-FAST
sudo apt-add-repository ppa:saiarcot895/myppa -y && sudo apt-get update && sudo apt-get -y install apt-fast

## UPDATE SYSTEM
sudo apt-fast -y --force-yes update && sudo apt-fast -y --force-yes upgrade

## REMOVE SOFTWARES
sudo apt-fast -y --force-yes autoremove software-center landscape-client-ui-install example-content rhythmbox* \
thunderbird* totem totem-common unity-lens-shopping unity-lens-friends \
unity-scope-musicstores unity-scope-video-remote

## DEACTIVATE LENSES
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
gsettings set com.canonical.Unity.Lenses remote-content-search 'none'

## ADD SOME REPOS
sudo add-apt-repository -y ppa:tualatrix/ppa # Ubuntu tweak
sudo add-apt-repository -y ppa:ubuntu-wine/ppa # Wine
sudo add-apt-repository -y ppa:webupd8team/atom # Atom
sudo add-apt-repository -y ppa:chris-lea/node.js # Nodejs
sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-fast -y --force-yes update

## INSTALL SOFTWARES
sudo apt-fast -y --force-yes install aptitude synaptic # Package manager
sudo apt-fast -y --force-yes install ubuntu-tweak # Config GUI
sudo apt-fast -y --force-yes install bleachbit # Memory cleaner
sudo apt-fast -y --force-yes install gparted # Partition manager
sudo apt-fast -y --force-yes install python-software-properties python g++ make # Nodejs deps
sudo apt-fast -y --force-yes install vlc exaile # Media tools
sudo apt-fast -y --force-yes install thunderbird thunderbird-locale-fr # Email client
sudo apt-fast -y --force-yes install gimp gimp-data gimp-plugin-registry gimp-data-extras # Image editor
sudo apt-fast -y --force-yes install terminator git atom # Dev tools
sudo apt-fast -y --force-yes install wine # Windows tool runner
sudo apt-fast -y --force-yes install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla \
                        icedax tagtool easytag id3tool lame nautilus-script-audio-convert \
                        libmad0 mpg321 gstreamer1.0-libav # Multimedia codecs
sudo apt-fast -y --force-yes install unace unrar zip unzip p7zip-full p7zip-rar sharutils \
                        rar uudeview mpack arj cabextract file-roller # Archive tools

## Node and npm install without sudo
mkdir ~/npm
sudo apt-fast install nodejs
npm config set prefix ~/npm
npm install -g bower
npm install -g grunt-cli

## Owncloud client
echo "deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_$(grep ^DISTRIB_RELEASE= /etc/lsb-release | cut -d= -f2)/ /" | sudo tee -a /etc/apt/sources.list.d/owncloud.list
wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_$(grep ^DISTRIB_RELEASE= /etc/lsb-release | cut -d= -f2)/Release.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install owncloud-client

## INSTALL THEMES FOR ATOM
apm install solarized-dark-ui
apm install solarized-light-ui

## INSTALL PACKAGES FOR ATOM
apm install save-session
apm install project-manager
apm install highlight-line
apm install sort-lines
apm install toggle-quotes
apm install color-picker
apm install todo-show
apm install atom-beautify
apm install autocomplete-plus
apm install git-plus
apm install git-blame
apm install javascript-snippets
apm install linter
apm install jshint
apm install linter-javac

## SETTINGS
# Privacy
gsettings set org.gnome.desktop.privacy remember-recent-files false
# Launcher
gsettings set com.canonical.Unity.Launcher favorites "['application://nautilus.desktop', 'application://firefox.desktop', 'application://thunderbird.desktop', 'application://atom.desktop', 'unity://expo-icon']"
# Datetime
gsettings set com.canonical.indicator.datetime show-date true
gsettings set com.canonical.indicator.datetime show-day true
gsettings set com.canonical.indicator.datetime show-seconds true
# Sound
gsettings set com.ubuntu.sound allow-amplified-volume true
# Workspace
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 2

## DOTFILES
source bootstrap.sh --force
