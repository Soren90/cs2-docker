# CS2 dockerized

This project is still in early development. But with this docker image you should be able to run a cs2 server in a pretty simple manner. Pull requests are open and I'll be happy to implement improvements to the project

## How to use

Install docker:
```bash
curl -fsSL https://get.docker.com/ -o install-docker.sh && sh install-docker.sh
```
  
Add your steam TOKEN to the docker-compose.yml check this link [gerenciar tokens](https://steamcommunity.com/dev/managegameservers) to generate your token.
Remembering to put the AppID as 730 (which refers to CS2)
  
start the server:
```bash
docker-compose up -d
```

If you need to modify the server files, you will find the server files here: /var/lib/docker/volumes/cs2-data/_data/ 

## TODO

- Fix RCON (Bugged for now. You can only use rcon_address outside of the server for now.)
- Get rid of host networking and automatically fetch the container IP.
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
      SERVER_PASSWORD: 
      RCON_PASSWORD: 
      IP: 0.0.0.0
      PORT: 27015
      GAME_TYPE: 0
      GAME_MODE: 1
      MAP: de_inferno
      MAXPLAYERS: 12
      TOKEN:

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
