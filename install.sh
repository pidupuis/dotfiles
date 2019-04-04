function installCommon() {
	## DEACTIVATE SCREEN SAVER
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend false
	gsettings set org.gnome.desktop.session idle-delay 0

	## UPDATE SYSTEM
	sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt autoremove -y

	## REMOVE SOFTWARES
	sudo apt-get -y autoremove software-center landscape-client-ui-install example-content rhythmbox* \
	thunderbird* totem totem-common

	## DEACTIVATE LENSES
	gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"
	gsettings set com.canonical.Unity.Lenses remote-content-search 'none'

	## ADD SOME REPOS
	sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
	wget -qO - https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
	sudo apt-get -y update

	## INSTALL SOFTWARES
	softs=(
		aptitude synaptic dconf-editor bleachbit gparted gnome-tweak-tool
		software-properties-common python gcc g++ make # Nodejs deps
		gimp gimp-data gimp-plugin-registry gimp-data-extras # Image editor
		terminator git atom vim curl google-chrome-stable # Dev tools
		unace unrar zip unzip p7zip-full p7zip-rar sharutils rar # Archive tools
		uudeview mpack arj cabextract file-roller
		)
	for s in "${softs[@]}"
	do
		sudo apt-get -y install $s
	done

	## Node and npm install without sudo
	curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
        sudo apt-get -y install nodejs yarn
        mkdir ~/npm
        npm config set prefix ~/npm
        
	
	## Python packages
	sudo apt autoremove python-pip
	sudo apt-get -y install python3-pip

	## ATOM THEMES AND PACKAGES
	atoms=(
		project-plus
		highlight-line
		sort-lines
		toggle-quotes
		color-picker
		todo-show
		atom-beautify
		git-plus
		git-blame
		file-icons
		)
	for p in "${atoms[@]}"
	do
		apm install $p
	done

	## SETTINGS
	# Privacy
	gsettings set org.gnome.desktop.privacy remember-recent-files false
	# Launcher
	gsettings set org.gnome.shell.extensions.dash-to-dock favorites "['application://nautilus.desktop', 'application://firefox.desktop', 'application://atom.desktop', 'unity://expo-icon']"
	# Datetime
	gsettings set com.canonical.indicator.datetime show-date true
	gsettings set com.canonical.indicator.datetime show-day true
	gsettings set com.canonical.indicator.datetime show-seconds true
	# Sound
	gsettings set com.ubuntu.sound allow-amplified-volume true
	# Workspace
	gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 2
	gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 2
}

function installPerso() {
	## ADD SOME REPOS
	sudo add-apt-repository -y ppa:atareao/telegram # Telegram

	## INSTALL SOFTWARES
	sudo apt-get -y install vlc exaile # Media tools
	sudo apt-get -y install wine # Windows tool runner
	sudo apt-get -y install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla \
		                icedax tagtool easytag id3tool lame nautilus-script-audio-convert \
		                libmad0 mpg321 gstreamer1.0-libav # Multimedia codecs
	sudo apt-get -y install telegram # Instant messaging
	cd ~/
	git clone git://github.com/joeyh/github-backup
	cd github-backup
	make

	## Owncloud client
	sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud-client.list"
	sudo apt-get -y update
	sudo apt-get -y install owncloud-client
}

## INSTALL
if [ "$1" == "--perso" -o "$1" == "-p" ]; then
	installCommon;
	installPerso;
else
	read -p "Would you like to install softwares usually dedicated to spare time ? (y/N) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		installCommon;
		installPerso;
	else
		installCommon;
	fi;
fi;

## DOTFILES
source bootstrap.sh --force

## UNSET
unset installCommon;
unset installPerso;
