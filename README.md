# Dotfiles

## Installation

/!\ Modify username and email on top of .gitconfig file before to use this script

```bash
cd ~/ && git clone https://github.com/pidupuis/dotfiles.git && cd dotfiles/ && git checkout alt/arch && bash install.sh
```
This will install preferred softwares and then apply the dotfiles script to configure system and softwares.

If you want to only install the system configuration without installing softwares:

```bash
cd ~/ && git clone https://github.com/pidupuis/dotfiles.git && cd dotfiles/ && git checkout alt/arch && source bootstrap.sh
```

To update config:

```bash
cd ~/dotfiles/ && source bootstrap.sh
```


## Contributions
The main author is [Mathias Bynens](https://mathiasbynens.be/) which did an incredible work to create the most efficient dotfiles script I've ever seen.

Thanks to [Matt Deacalion](https://github.com/Matt-Deacalion/arch-dotfiles) for his work concerning arch dotfiles.

Thanks to [Isaacs](https://gist.github.com/isaacs/579814) for his npm install without sudo.
