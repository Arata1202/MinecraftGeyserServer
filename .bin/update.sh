VERSION=$(curl -s "https://api.papermc.io/v2/projects/paper" | jq -r '.versions[-1]')
BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${VERSION}" | jq -r '.builds[-1]')
curl -f -L -o Paper.jar \
    "https://api.papermc.io/v2/projects/paper/versions/${VERSION}/builds/${BUILD}/downloads/paper-${VERSION}-${BUILD}.jar"

curl -f -L -o plugins/Geyser-Spigot.jar \
    "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

curl -f -L -o plugins/Floodgate-Spigot.jar \
    "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"

curl -f -L -o plugins/Via-Version.jar \
    "https://api.spiget.org/v2/resources/19254/download"

curl -f -L -o plugins/DiscordSRV.jar \
    "https://download.discordsrv.com/v2/DiscordSRV/DiscordSRV/release/download/latest/jar"

curl -f -L -o LunaChat.jar \
    "https://api.spiget.org/v2/resources/82293/download"

curl -f -L -o Skript.jar \
        "https://api.spiget.org/v2/resources/114544/download"

curl -f -L -o DeathChest.jar \
    "https://api.spiget.org/v2/resources/101066/download"
