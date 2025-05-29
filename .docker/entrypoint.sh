#!/bin/bash

set -e

if [ ! -f "./Paper.jar" ]; then
    VERSION=$(curl -s "https://api.papermc.io/v2/projects/paper" | jq -r '.versions[-1]')
    BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${VERSION}" | jq -r '.builds[-1]')
    curl -o Paper.jar \
        "https://api.papermc.io/v2/projects/paper/versions/${VERSION}/builds/${BUILD}/downloads/paper-${VERSION}-${BUILD}.jar"

    java -Xmx2G -Xms2G -jar Paper.jar &

    while [ ! -f "eula.txt" ]; do
        sleep 1
    done
fi

if grep -q 'eula=false' "eula.txt"; then
    sed -i 's/eula=false/eula=true/' "eula.txt"
fi

if [ ! -f "./Geyser-Spigot.jar" ] && [ ! -f "./plugins/Geyser-Spigot.jar" ]; then
    curl -L -o Geyser-Spigot.jar \
        "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
fi

if [ ! -f "./Floodgate-Spigot.jar" ] && [ ! -f "./plugins/Floodgate-Spigot.jar" ]; then
    curl -L -o Floodgate-Spigot.jar \
        "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"
fi

if [ ! -f "./Via-Version.jar" ] && [ ! -f "./plugins/Via-Version.jar" ]; then
    curl -L -o Via-Version.jar \
        "https://api.spiget.org/v2/resources/19254/download"
fi

if [ ! -f "./DiscordSRV.jar" ] && [ ! -f "./plugins/DiscordSRV.jar" ]; then
    curl -L -o DiscordSRV.jar \
        "https://download.discordsrv.com/v2/DiscordSRV/DiscordSRV/release/download/latest/jar"
fi

if [ ! -f "./LunaChat.jar" ] && [ ! -f "./plugins/LunaChat.jar" ]; then
    curl -L -o LunaChat.jar \
        "https://api.spiget.org/v2/resources/82293/download"
fi

if [ ! -f "./Skript.jar" ] && [ ! -f "./plugins/Skript.jar" ]; then
    curl -L -o Skript.jar \
        "https://api.spiget.org/v2/resources/114544/download"
fi

if [ ! -f "./DeathChest.jar" ] && [ ! -f "./plugins/DeathChest.jar" ]; then
    curl -L -o DeathChest.jar \
        "https://api.spiget.org/v2/resources/101066/download"
fi

if [ ! -f "./plugins/Geyser-Spigot.jar" ] || [ ! -f "./plugins/Floodgate-Spigot.jar" ] || [ ! -f "./plugins/Via-Version.jar" ] || [ ! -f "./plugins/DiscordSRV.jar" ] || [ ! -f "./plugins/LunaChat.jar" ] || [ ! -f "./plugins/Skript.jar" ] || [ ! -f "./plugins/DeathChest.jar" ]; then
    if [ ! -f "./plugins/Geyser-Spigot.jar" ]; then
        mv ./Geyser-Spigot.jar plugins/
    fi

    if [ ! -f "./plugins/Floodgate-Spigot.jar" ]; then
        mv ./Floodgate-Spigot.jar plugins/
    fi

    if [ ! -f "./plugins/Via-Version.jar" ]; then
        mv ./Via-Version.jar plugins/
    fi

    if [ ! -f "./plugins/DiscordSRV.jar" ]; then
        mv ./DiscordSRV.jar plugins/
    fi

    if [ ! -f "./plugins/LunaChat.jar" ]; then
        mv ./LunaChat.jar plugins/
    fi

    if [ ! -f "./plugins/Skript.jar" ]; then
        mv ./Skript.jar plugins/
    fi

    if [ ! -f "./plugins/DeathChest.jar" ]; then
        mv ./DeathChest.jar plugins/
    fi

    java -Xmx2G -Xms2G -jar Paper.jar &

    while [ ! -f "./plugins/Geyser-Spigot/config.yml" ] || [ ! -f "server.properties" ] || [ ! -f "plugins/DiscordSRV/config.yml" ] || [ ! -f "plugins/LunaChat/config.yml" ] || [ ! -d "plugins/Skript/scripts" ] || [ ! -f "plugins/DeathChest/config.yml" ]; do
        sleep 1
    done
fi

if grep -q 'auth-type: online' "plugins/Geyser-Spigot/config.yml"; then
    sed -i 's/auth-type: online/auth-type: floodgate/' "plugins/Geyser-Spigot/config.yml"
fi

if grep -q 'Experiment_WebhookChatMessageDelivery: false' "plugins/DiscordSRV/config.yml"; then
    sed -i 's/Experiment_WebhookChatMessageDelivery: false/Experiment_WebhookChatMessageDelivery: true/' "plugins/DiscordSRV/config.yml"
fi

if grep -q 'DisabledPluginHooks: *\[]' "plugins/DiscordSRV/config.yml"; then
    sed -i 's/DisabledPluginHooks: *\[]/DisabledPluginHooks: ["LunaChat"]/' "plugins/DiscordSRV/config.yml"
fi

if grep -q 'japanizeType: none' "plugins/LunaChat/config.yml"; then
    sed -i 's/japanizeType: none/japanizeType: GoogleIME/' "plugins/LunaChat/config.yml"
fi

if grep -q 'expiration: 600' "plugins/DeathChest/config.yml"; then
    sed -i 's/expiration: 600/expiration: -1/' "plugins/DeathChest/config.yml"
fi

if grep -q 'blast-protection: false' "plugins/DeathChest/config.yml"; then
    sed -i 's/blast-protection: false/blast-protection: true/' "plugins/DeathChest/config.yml"
fi

if grep -A 3 '^change-death-message:' "plugins/DeathChest/config.yml" | grep -q '  enabled: false'; then
    sed -i '/^change-death-message:/,/^[^ ]/s/^  enabled: false/  enabled: true/' "plugins/DeathChest/config.yml"
fi

if grep -q 'enforce-secure-profile=true' "server.properties"; then
    sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "server.properties"
fi

if grep -q 'white-list=false' "server.properties"; then
    sed -i 's/white-list=false/white-list=true/' "server.properties"
fi

if ! grep -q 'enable-rcon=true' "server.properties"; then
    echo 'enable-rcon=true' >> "server.properties"
fi

if ! grep -q 'rcon.port=25575' "server.properties"; then
    echo 'rcon.port=25575' >> "server.properties"
fi

if ! grep -q 'rcon.password=minecraft' "server.properties"; then
    echo 'rcon.password=minecraft' >> "server.properties"
fi

cp ./skript/death.sk plugins/Skript/scripts/

exec "$@"
