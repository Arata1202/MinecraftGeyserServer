if [ ! -f "./plugins/Geyser-Spigot.jar" ] && [ ! -f "./Geyser-Spigot.jar" ]; then
  curl -L -o Geyser-Spigot.jar \
    "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
fi
