function installCommon() {
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
	sudo add-apt-repository -y ppa:webupd8team/atom # Atom
	sudo add-apt-repository -y ppa:chris-lea/node.js # Nodejs
	sudo add-apt-repository -y "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
	sudo apt-fast -y --force-yes update

	## INSTALL SOFTWARES
	softs=(
		aptitude synaptic # Package manager
		ubuntu-tweak # Config GUI
		bleachbit # Memory cleaner
		gparted # Partition manager
		python-software-properties python g++ make # Nodejs deps
		thunderbird thunderbird-locale-fr # Email client
		gimp gimp-data gimp-plugin-registry gimp-data-extras # Image editor
		terminator git atom vim # Dev tools
		unace unrar zip unzip p7zip-full p7zip-rar sharutils rar # Archive tools
		uudeview mpack arj cabextract file-roller
		)
	for s in "${softs[@]}"
	do
		sudo apt-fast -y --force-yes install $s
	done

	## Node and npm install without sudo
	mkdir ~/npm
	sudo apt-fast install nodejs
	npm config set prefix ~/npm
	npm install -g bower
	npm install -g grunt-cli

	## ATOM THEMES AND PACKAGES
	atoms=(
		solarized-dark-ui
		solarized-light-ui
		save-session
		project-manager
		highlight-line
		sort-lines
		toggle-quotes
		color-picker
		todo-show
		atom-beautify
		autocomplete-plus
		git-plus
		git-blame
		javascript-snippets
		linter
		jshint
		go-to-line
		angularjs
		)
	for p in "${atoms[@]}"
	do
		apm install $p
	done

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
}

function installPerso() {
	## ADD SOME REPOS
	sudo add-apt-repository -y ppa:ubuntu-wine/ppa # Wine
	sudo add-apt-repository -y ppa:atareao/telegram # Telegram

	## INSTALL SOFTWARES
	sudo apt-fast -y --force-yes install vlc exaile # Media tools
	sudo apt-fast -y --force-yes install wine # Windows tool runner
	sudo apt-fast -y --force-yes install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla \
		                icedax tagtool easytag id3tool lame nautilus-script-audio-convert \
		                libmad0 mpg321 gstreamer1.0-libav # Multimedia codecs
	sudo apt-fast -y --force-yes install pidgin pidgin-otr # XMPP client
	sudo apt-fast -y --force-yes install telegram # Instant messaging
	cd ~/
	git clone git://github.com/joeyh/github-backup
	cd github-backup
	make

	## Owncloud client
	echo "deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_$(grep ^DISTRIB_RELEASE= /etc/lsb-release | cut -d= -f2)/ /" | sudo tee -a /etc/apt/sources.list.d/owncloud.list
	wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_$(grep ^DISTRIB_RELEASE= /etc/lsb-release | cut -d= -f2)/Release.key -O - | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install owncloud-client
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
