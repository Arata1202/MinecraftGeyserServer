if [ ! -f "./plugins/Floodgate-Spigot.jar" ] && [ ! -f "./Floodgate-Spigot.jar" ]; then
  curl -L -o Floodgate-Spigot.jar \
    "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
fi
