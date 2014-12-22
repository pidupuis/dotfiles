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
sudo add-apt-repository -y ppa:tualatrix/ppa
sudo add-apt-repository -y ppa:ubuntu-wine/ppa
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:webupd8team/atom
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-fast -y --force-yes update

## INSTALL SOFTWARES
sudo apt-fast -y --force-yes install aptitude synaptic ubuntu-tweak bleachbit \
                        python-software-properties python g++ make oracle-java7-installer \
                        vlc exaile chromium-browser skype thunderbird thunderbird-locale-fr nautilus-dropbox \
                        gimp gimp-data gimp-plugin-registry gimp-data-extras \
                        terminator git atom nodejs mysql-workbench virtualbox virtualbox-qt virtualbox-dkms \
                        wine steam \
                        gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla icedax tagtool easytag id3tool lame nautilus-script-audio-convert libmad0 mpg321 gstreamer1.0-libav \
                        flashplugin-installer \
                        unace unrar zip unzip p7zip-full p7zip-rar sharutils rar uudeview mpack arj cabextract file-roller

## INSTALL THEMES FOR ATOM
apm install solarized-dark-ui
apm install solarized-light-ui

## DOTFILES
cd dotfiles && source bootstrap.sh --force
