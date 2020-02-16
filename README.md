
# Dotfiles

Use this repo to configure a Plesk server on Digital Ocean.
After the server is added, `ssh` in as the `root` user and run `sudo plesk login`. Then configure the Plesk admin (including installing Node.js).
Once that has been done, run the command below to install DigitalOceans metrics agent and set up the server to run `ZSH`.

```bash
	wget -qO install https://raw.githubusercontent.com/workwithizzi/server-dotfiles/master/install && sudo bash install
```