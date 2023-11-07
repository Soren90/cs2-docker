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

You can also use EXTRAARG to add it like this:
```yaml
EXTRAARG: "+login AAAAA"
```

If you need to modify the server files, you will find the server files here: /var/lib/docker/volumes/cs2-data/_data/ 

## TODO

- Fix RCON (Bugged for now. You can only use rcon_address outside of the server for now.)
- Get rid of host networking and automatically fetch the container IP.
- Make it possible to modify server.cfg. For now it gets replaced on startup (Thanks valve)
- Add sourcemod/metamod when ready
- Put username/password into secret
- Improve this document

## RCON workaround
My workaround for now is to use [shobhit-pathak/cs2-rcon-panel](https://github.com/shobhit-pathak/cs2-rcon-panel)
  
Docker image for the panel might not be up to date, as I'm not the maintainer, but here is a POC:
```yaml
version: "3.7"

volumes:
  cs2-data:
    name: cs2-data

services:
  csgo:
    image: soren90/cs2
    container_name: cs2-ds

    environment:
      SERVER_HOSTNAME: "Counter-strike 2 Dedicated server"
      SERVER_PASSWORD: ""
      RCON_PASSWORD: "" 
      IP: 0.0.0.0
      PORT: 27015
      GAME_TYPE: 0
      GAME_MODE: 1
      MAP: de_inferno
      MAXPLAYERS: 12
      MAPGROUP: mg_active
      USER:
      PASSWORD:
      EXTRAARG: ""

    volumes:
      - type: volume
        source: cs2-data
        target: /mnt/server

    network_mode: "host"

    restart: unless-stopped
    stdin_open: true
    tty: true
  rconpanel:
    image: soren90/rcon-panel
    ports:
      - "3000:3000"
    restart: unless-stopped

```

## Credits

This is heavily inspired by [kaimallea/csgo](https://github.com/kaimallea/csgo)  
Great webpanel for RCON:  [shobhit-pathak/cs2-rcon-panel](https://github.com/shobhit-pathak/cs2-rcon-panel)
