if screen -list | grep -q "minecraft"; then
  ./.bin/stop/cmd/server.sh

  while screen -list | grep -q "minecraft"; do
    sleep 1
  done
fi
