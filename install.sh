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

## DOTFILES
cd dotfiles && source bootstrap.sh --force
