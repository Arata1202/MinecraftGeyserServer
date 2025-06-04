set -a
source /home/ubuntu/MinecraftGeyserServer/.env
set +a

mcrcon -H 127.0.0.1 -P 25575 -p ${RCON_PASSWORD} stop

while pgrep -f "java.*Paper.jar" > /dev/null; do
  sleep 1
done
