# Dotfiles

## Installation

/!\ Modify username and email on top of .gitconfig file before to use this script

```bash
cd ~/ && git clone https://github.com/pidupuis/dotfiles.git && cd dotfiles/ && bash install.sh
```
This will install preferred softwares and then apply the dotfiles script to configure system and softwares.

To update config, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```


## Contributions
The main author is [Mathias Bynens](https://mathiasbynens.be/) which did an incredible work to create the most efficient dotfiles script I've ever seen. I still had to adapt his work for an Ubuntu environnement with Firefox, Atom and Terminator.

I have to thanks [Evan Hahn](http://evanhahn.com/) for his custom vimperator config which is perfect since it is adapted to the use of DuckduckGo, Ghostery and NoScript. 

