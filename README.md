# CS2 dockerized

This project is still in early development. But with this docker image you should be able to run a cs2 server in a pretty simple manner. Pull requests are open and I'll be happy to implement improvements to the project

## How to use

Install docker:
```bash
curl -fsSL https://get.docker.com/ -o install-docker.sh | sh install-docker.sh
```
  
Add your steam username and password to the docker-compose.yml (Ideally a seperate account that doesn't have steam guard if possible. Not tested)
  
start the server:
```bash
docker-compose up -d
```

If you are using an account with steamguard enabled, you need to attach the container and put in your code
```bash
docker attach cs2-ds
```

If you need to modify the server files, you will find the server files here: /var/lib/docker/volumes/cs2-data/_data/ 

## TODO

- Fix RCON
- Get rid of host networking and automatically fetch the container IP.
- Add sourcemod/metamod when ready
- Put username/password into secret
- Improve this document

## Credits

This is heavily inspired by [kaimallea/csgo](https://github.com/kaimallea/csgo)  
Remote RCON with this tool seems like a good addition for now [shobhit-pathak/cs2-rcon-panel](https://github.com/shobhit-pathak/cs2-rcon-panel)
