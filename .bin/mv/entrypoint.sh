if [ ! -f "./plugins/Floodgate-Spigot.jar" ] && [ ! -f "./plugins/Geyser-Spigot.jar" ] && [ ! -f "./plugins/Via-Version.jar" ]; then
  ./.bin/mv/cmd/jar.sh

  ./.bin/reboot.sh

  while [ ! -f "./plugins/Geyser-Spigot/config.yml" ] || [ ! -f "server.properties" ]; do
    sleep 1
  done
fi
