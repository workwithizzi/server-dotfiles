# Dotfiles

Use this repo to configure a bare Ubuntu server on Digital Ocean.

## Installation
After the server is created, `ssh` in as `root` user and clone this repo to the `$HOME` directory--make sure to change the directory name to `_dotfiles`

``` bash
	git clone https://github.com/workwithizzi/server-dotfiles $HOME/_dotfiles
```

Start the install script:
```bash
	. "$HOME/_dotfiles/setup/install_start.sh"
```
