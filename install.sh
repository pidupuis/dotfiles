function installCommon() {
	## SETTINGS
	# Privacy
	gsettings set org.gnome.desktop.privacy remember-recent-files false
	# Deactivate screen saver
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0

	## UPDATE SYSTEM
	sudo yum -y update && sudo yum -y upgrade

	## INSTALL SOFTWARES
	softs=(
		bleachbit # Memory cleaner
		gparted # Partition manager
		bind-utils vim iotop screen yum-utils lm_sensors
		gimp gimp-data-extras # Image editor
		terminator git vim curl # Dev tools
		zip unzip sharutils # Archive tools
		arj cabextract file-roller
		)
	for s in "${softs[@]}"
	do
		sudo yum -y install $s
	done

	curl -sL https://github.com/atom/atom/releases/download/v1.10.2/atom.x86_64.rpm > /tmp/atom.x86_64.rpm
	sudo yum -y install /tmp/atom.x86_64.rpm

	## Node and npm install without sudo
	curl -sL https://rpm.nodesource.com/setup_4.x | bash -
        sudo yum -y install nodejs
        mkdir ~/npm
        npm config set prefix ~/npm
	npm set progress=false
        npm install -g npm@latest
	npm install -g bower
	npm install -g grunt-cli
	npm install -g gulp
	
	## Python packages
	sudo yum -y install python-pip
	sudo pip install --upgrade pip
	sudo pip install flake8

	## ATOM THEMES AND PACKAGES
	atoms=(
		save-session
		project-manager
		highlight-line
		sort-lines
		toggle-quotes
		color-picker
		todo-show
		atom-beautify
		javascript-snippets
		linter
		jshint
		angularjs
		linter-flake8
		file-icons
		)
	for p in "${atoms[@]}"
	do
		apm install $p
	done
}

function installPerso() {
	echo "Nothing to install"
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
