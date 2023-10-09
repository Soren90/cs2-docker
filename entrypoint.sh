sleep 1
# Mandatory variables check
: "${STEAM_DIR:?'ERROR: STEAM_DIR IS NOT SET!'}"
: "${STEAMCMD_DIR:?'ERROR: STEAMCMD_DIR IS NOT SET!'}"
: "${CS2_DIR:?'ERROR: CSGO_DIR IS NOT SET!'}"
: "${USER:?'ERROR: USER IS NOT SET!'}"
: "${PASSWORD:?'ERROR: PASSWORD IS NOT SET!'}"

# Set defaults
export SERVER_HOSTNAME="${SERVER_HOSTNAME:-cs2server}"
export PORT="${PORT:-27015}"
export GAME_TYPE="${GAME_TYPE:-0}"
export GAME_MODE="${GAME_MODE:-1}"
export MAP="${MAP:-de_dust2}"
export MAPGROUP="${MAPGROUP:-mg_active}"
export MAXPLAYERS="${MAXPLAYERS:-12}"
export IP="${IP:-0.0.0.0}"

# Copy competitive configs
mkdir -p ${CS2_DIR}/game/csgo/cfg
cp /mnt/cfg/* ${CS2_DIR}/game/csgo/cfg

if [ ! -s "$CS2_DIR/game/csgo/cfg/autoexec.cfg" ]; then
cat << AUTOEXECCFG > "$CS2_DIR/game/csgo/cfg/autoexec.cfg"
log on
hostname "$SERVER_HOSTNAME"
rcon_password "$RCON_PASSWORD"
sv_password "$SERVER_PASSWORD"
sv_cheats 0
tv_delaymapchange 1
tv_delay 30
tv_deltacache 2
tv_dispatchmode 1
tv_maxclients 10
tv_maxrate 0
tv_overridemaster 0
tv_relayvoice 1
tv_snapshotrate 64
tv_timeout 60
tv_transmitall 1
writeid
writeip
exec banned_user.cfg
exec banned_ip.cfg
exec warmup.cfg
AUTOEXECCFG

else
sed -i "s/^hostname.*/hostname \"$SERVER_HOSTNAME\"/" $CS2_DIR/game/csgo/cfg/autoexec.cfg
sed -i "s/^rcon_password.*/rcon_password \"$RCON_PASSWORD\"/" $CS2_DIR/game/csgo/cfg/autoexec.cfg
sed -i "s/^sv_password.*/sv_password \"$SERVER_PASSWORD\"/" $CS2_DIR/game/csgo/cfg/autoexec.cfg

fi

# Install/update game
${STEAMCMD_DIR}/steamcmd.sh +login "${USER}" "${PASSWORD}" ${STEAMGUARDCODE} +force_install_dir ${CS2_DIR} +app_update 730 +quit

# hacky error fix
mkdir -p ${STEAM_DIR}/.steam/sdk32
mkdir -p ${STEAM_DIR}/.steam/sdk64

cp ${STEAMCMD_DIR}/linux32/steamclient.so ${STEAM_DIR}/.steam/sdk32/steamclient.so
cp ${STEAMCMD_DIR}/linux64/steamclient.so ${STEAM_DIR}/.steam/sdk64/steamclient.so

# Start gameserver
${CS2_DIR}/game/cs2.sh +ip ${IP} -port ${PORT} -dedicated -game csgo -console -usercon +map ${MAP} +gametype ${GAME_TYPE} +gamemode ${GAME_MODE} +exec autoexec.cfg ${EXTRAARG}
