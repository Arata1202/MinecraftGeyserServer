VERSION=$(curl -s "https://api.papermc.io/v2/projects/folia" | jq -r '.versions[-1]')
BUILD=$(curl -s "https://api.papermc.io/v2/projects/folia/versions/${VERSION}" | jq -r '.builds[-1]')
curl -f -o Folia.jar \
    "https://api.papermc.io/v2/projects/folia/versions/${VERSION}/builds/${BUILD}/downloads/folia-${VERSION}-${BUILD}.jar"

curl -f -L -o plugins/Geyser-Spigot.jar \
    "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

curl -f -L -o plugins/Floodgate-Spigot.jar \
    "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"

curl -f -L -o plugins/Via-Version.jar \
    "https://api.spiget.org/v2/resources/19254/download"
