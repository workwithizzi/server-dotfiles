# Dotfiles

Use this repo to configure a bare Ubuntu server on Digital Ocean.
After the server is added, `ssh` in as the `root` user and clone this repo to the `$HOME` directory. Make sure to change the directory name to `_dotfiles` 

``` bash
	git clone https://github.com/workwithizzi/server-dotfiles $HOME/_dotfiles
```

## Merge hooks

To merge the hook files from `hooks` directory:

* Run `node combiner/index` 
