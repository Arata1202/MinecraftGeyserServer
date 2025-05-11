if [ ! -f "./Paper.jar" ]; then
    VERSION=$(curl -s "https://api.papermc.io/v2/projects/paper" | jq -r '.versions[-1]')
    BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${VERSION}" | jq -r '.builds[-1]')
    curl -o Paper.jar \
        "https://api.papermc.io/v2/projects/paper/versions/${VERSION}/builds/${BUILD}/downloads/paper-${VERSION}-${BUILD}.jar"

    curl -L -o Geyser-Spigot.jar \
        "https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"

    curl -L -o Floodgate-Spigot.jar \
        "https://download.geysermc.org/v2/projects/floodgate/versions/latest/builds/latest/downloads/spigot"

    curl -L -o Via-Version.jar \
        "https://api.spiget.org/v2/resources/19254/download"

    java -Xmx2G -Xms2G -jar Paper.jar &
    JAVA_PID=$!

    while [ ! -f "eula.txt" ]; do
        sleep 1
    done

    kill "$JAVA_PID"
fi

sed -i 's/eula=false/eula=true/' "eula.txt"

if [ ! -f "./plugins/Floodgate-Spigot.jar" ] && [ ! -f "./plugins/Geyser-Spigot.jar" ] && [ ! -f "./plugins/Via-Version.jar" ]; then
    mv ./Floodgate-Spigot.jar plugins/
    mv ./Geyser-Spigot.jar plugins/
    mv ./Via-Version.jar plugins/

    java -Xmx2G -Xms2G -jar Paper.jar &
    JAVA_PID=$!

    while [ ! -f "./plugins/Geyser-Spigot/config.yml" ] || [ ! -f "server.properties" ]; do
        sleep 1
    done

    kill "$JAVA_PID"
fi

sed -i 's/auth-type: online/auth-type: floodgate/' "plugins/Geyser-Spigot/config.yml"

sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "server.properties"
echo 'enable-rcon=true' >> "server.properties"
echo 'rcon.port=25575' >> "server.properties"
echo 'rcon.password=minecraft' >> "server.properties"
