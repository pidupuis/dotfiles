function installCommon() {
	sudo pacman Syyu

	## INSTALL SOFTWARES
	softs=(
			rsync, vim, nodejs
	)
	for s in "${softs[@]}"
	do
		pacman -Sy $s
	done

	## NPM
  mkdir ~/npm
  npm config set prefix ~/npm
  npm install -g npm@latest
	npm install -g bower

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
		git-plus
		git-blame
		javascript-snippets
		linter
		jshint
		angularjs
		linter-pep8
		linter-pyflakes
		file-icons
		)
	for p in "${atoms[@]}"
	do
		apm install $p
	done
}

function installPerso() {

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
