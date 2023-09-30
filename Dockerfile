FROM        registry.gitlab.steamos.cloud/steamrt/sniper/platform 

ENV         STEAMCMD_DIR /mnt/server/steamcmd
ENV         CS2_DIR /mnt/server/cs2
ENV         STEAM_DIR /mnt/server

RUN         adduser --disabled-password --gecos "" steam && \
            mkdir -p ${STEAMCMD_DIR} && \
            mkdir -p ${CS2_DIR}/steamapps && \
            mkdir -p /mnt/cfg && \
            curl -sSL https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar -zx -C /mnt/server/steamcmd && \
            chown -R steam:steam /mnt/server
ENV         DEBIAN_FRONTEND=noninteractive
USER        steam
ENV         USER=steam HOME=/mnt/server
WORKDIR     /mnt/server

COPY        entrypoint.sh /entrypoint.sh
COPY        cfg/* /mnt/cfg
CMD         [ "/bin/bash", "/entrypoint.sh" ]
