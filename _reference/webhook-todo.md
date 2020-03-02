# Todo for Production Server

## Create a 'new-site' script

[x] Creates a new `www` directory for the domain
[x] Provides option for defining a public directory, defaults to `root/public` 
[] Asks to integrate with a github repo

	[] If yes: asks for the branch, defaults to master
	[] If no: creates a placeholder `index.html` file in the public root

[] Creates the nginx file and provisions it with the given parameters
[] Asks if domain DNS has been configured

	[] If yes: saves info to file that it was manually configured
	[] If no: asks to configure it automatically

[] Asks to generate SSL cert, reminding that the domain needs to be pointed to the server

		[] If no, tells user that it can be generated later using a function

[] Saves site info to a specific file for future reference

  + domain name
  + creation dateTime
  + repo (bool)
  + repo url
  + if SSL cert has been created

[] If adding a git-repo, create a post-checkout hook to rebuild files (make sure to make it executable)

* www/
  + example.com/
    - info.txt
    - hooks.json
    - deploy-script.sh
    - live/
			- .git/
			- node_modules/
			- public/
				- index.html
			- package.json
			- base-file-one
			- base-file-two

### Misc files created for each site

* /etc/letsencrypt/renewal/example.com.conf
* /etc/letsencrypt/live/example.com/
* /etc/letsencrypt/archive/example.com/
