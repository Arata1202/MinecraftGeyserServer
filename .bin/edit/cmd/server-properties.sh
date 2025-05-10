FILE="server.properties"

sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "$FILE"
echo 'enable-rcon=true' >> "$FILE"
echo 'rcon.port=25575' >> "$FILE"
echo 'rcon.password=minecraft' >> "$FILE"
