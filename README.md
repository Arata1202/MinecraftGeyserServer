## Getting Started

### Installing Paper

Download Paper from [https://papermc.io/downloads/paper](https://papermc.io/downloads/paper) and place it in the root directory.

```bash

# Create the boot.sh file with the server startup command
touch boot.sh
echo "java -Xmx8G -Xms8G -jar paper-1.21.4-222.jar" > boot.sh

# Grant execute permission to boot.sh
chmod +x boot.sh

# Run the server to generate plugin configuration files
./boot.sh

# Change 'eula=false' to 'eula=true' in the eula.txt
nano eula.txt

```

### Installing Geyser and Floodgate

Download Geyser-Spigot.jar and Floodgate-Spigot.jar from [https://geysermc.org/download](https://geysermc.org/download) and place them in the plugins directory.

```bash

# Run the server to generate plugin configuration files
./boot.sh

# Change 'auth-type: online' to 'auth-type: floodgate' in the config.yml
cd plugins/Geyser-Spigot
nano config.yml
cd ../..

# Change 'enforce-secure-profile=true' to 'enforce-secure-profile=false' in the server.properties
nano server.properties

```

### Installing ViaVersion

Download ViaVersion from [https://www.spigotmc.org/resources/viaversion.19254](https://www.spigotmc.org/resources/viaversion.19254) and place them in the plugins directory.

```bash

# Run the server
./boot.sh

```

### Accessing the Server

| Connection Source | Server Address                  |
| ----------------- | ------------------------------- |
| Host machine      | localhost                       |
| Other devices     | Host machine's local IP address |

```bash

# Find the local IP address of the host machine
ipconfig getifaddr en0

```
