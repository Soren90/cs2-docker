# Counter Strike 2 Server - CS2 Dockerized

This project is still in early development. But with this docker image you should be able to run a CS2 Server in a pretty simple manner. Pull requests are open and I'll be happy to implement improvements to the project

## How to use

> [!WARNING]
> It is important that you already have Docker installed, if not, I have left some steps below, if you read carefully you will be able to install and run the containers.

Install Docker on Ubuntu/Debian:

Step 1:
```bash
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Step 2:
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

> [!IMPORTANT]
> If you are using an architecture other than Debian, check the link: [Install Docker Engine](https://docs.docker.com/engine/install/)



> [!WARNING]
> Add your steam TOKEN to the docker-compose.yml check this link [manage tokens](https://steamcommunity.com/dev/managegameservers) to generate your token.
> Remembering to put the AppID as 730 (which refers to CS2)

## Start the server
> [!IMPORTANT]
> Copy the contents of the docker-compose.yaml file and paste it into a file with the same name on your machine

And start the server:
```bash
docker compose up -d
```

If you need to modify the server files, you will find the server files here: /var/lib/docker/volumes/cs2-data/_data/ 

## TODO

- Fix RCON (Bugged for now. You can only use rcon_address outside of the server for now.)
- Get rid of host networking and automatically fetch the container IP.
- Add sourcemod/metamod when ready
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
