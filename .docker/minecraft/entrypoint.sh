#!/bin/bash

set -e

set -a
source .env
set +a

if [ ! -f "./Paper.jar" ]; then
    cp ./jar/Paper.jar ./

    java -Xmx2G -Xms2G -jar Paper.jar &

    while [ ! -f "eula.txt" ]; do
        sleep 1
    done

    sed -i 's/eula=false/eula=true/' "eula.txt"
fi

# Check if plugins are already installed
if [ ! -f "./plugins/Geyser-Spigot.jar" ] || \
   [ ! -f "./plugins/Floodgate-Spigot.jar" ] || \
   [ ! -f "./plugins/Via-Version.jar" ] || \
   [ ! -f "./plugins/DiscordSRV.jar" ] || \
   [ ! -f "./plugins/LunaChat.jar" ] || \
   [ ! -f "./plugins/DeathChest.jar" ] || \
   [ ! -f "./plugins/Dynmap.jar" ]; then
    for file in ./jar/*.jar; do
        if [[ $(basename "$file") != "Paper.jar" ]]; then
            cp "$file" ./plugins/
        fi
    done


    java -Xmx2G -Xms2G -jar Paper.jar &

    # Wait for the server to start and generate necessary files
    while [ ! -f "server.properties" ] || \
          [ ! -f "plugins/Geyser-Spigot/config.yml" ] || \
          [ ! -f "plugins/DiscordSRV/config.yml" ] || \
          [ ! -f "plugins/LunaChat/config.yml" ] || \
          [ ! -f "plugins/DeathChest/config.yml" ]; do
        sleep 1
    done

    # server.properties
    sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "server.properties"
    sed -i 's/white-list=false/white-list=true/' "server.properties"
    echo 'enable-rcon=true' >> "server.properties"
    echo 'rcon.port=25575' >> "server.properties"
    echo "rcon.password=${RCON_PASSWORD}" >> server.properties

    # Geyser-Spigot
    sed -i 's/auth-type: online/auth-type: floodgate/' "plugins/Geyser-Spigot/config.yml"

    # DiscordSRV
    sed -i 's/Experiment_WebhookChatMessageDelivery: false/Experiment_WebhookChatMessageDelivery: true/' "plugins/DiscordSRV/config.yml"
    sed -i 's/DisabledPluginHooks: *\[]/DisabledPluginHooks: ["LunaChat"]/' "plugins/DiscordSRV/config.yml"

    # LunaChat
    sed -i 's/japanizeType: none/japanizeType: GoogleIME/' "plugins/LunaChat/config.yml"

    # DeathChest
    sed -i 's/expiration: 600/expiration: -1/' "plugins/DeathChest/config.yml"
    sed -i 's/blast-protection: false/blast-protection: true/' "plugins/DeathChest/config.yml"
    sed -i '/^change-death-message:/,/^[^ ]/s/^  enabled: false/  enabled: true/' "plugins/DeathChest/config.yml"
fi

exec "$@"
