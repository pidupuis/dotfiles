function installCommon() {
	## UPDATE SYSTEM
	sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt autoremove -y

	## REMOVE SOFTWARES
	sudo apt-get -y autoremove software-center landscape-client-ui-install example-content rhythmbox* \
	thunderbird* totem totem-common

	## ADD SOME REPOS
	sudo sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb
	sudo apt-get -y update

	## INSTALL SOFTWARES
        sudo apt install -y ./slack-desktop-*.deb
        softs=(
		aptitude synaptic dconf-editor bleachbit gparted gnome-tweak-tool
		software-properties-common python gcc g++ make # Nodejs deps
		gimp gimp-data gimp-plugin-registry gimp-data-extras # Image editor
		terminator git vim curl google-chrome-stable # Dev tools
		unace unrar zip unzip p7zip-full p7zip-rar sharutils rar # Archive tools
		uudeview mpack arj cabextract file-roller
		)
	for s in "${softs[@]}"
	do
		sudo apt-get -y install $s
	done

	## Node and npm install without sudo
	curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
        sudo apt-get -y install nodejs
        mkdir ~/npm
        npm config set prefix ~/npm
        sudo npm install -g n
        sudo n 13.7.0
        curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
        echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
        sudo apt update
        sudo apt install yarn
}

function installPerso() {
	## ADD SOME REPOS
	sudo add-apt-repository -y ppa:atareao/telegram # Telegram

	## INSTALL SOFTWARES
	sudo apt-get -y install vlc # Media tools
	sudo apt-get -y install gstreamer0.10-plugins-ugly gxine libdvdread4 totem-mozilla \
		                icedax tagtool easytag id3tool lame nautilus-script-audio-convert \
		                libmad0 mpg321 gstreamer1.0-libav # Multimedia codecs
	sudo apt-get -y install telegram # Instant messaging
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
