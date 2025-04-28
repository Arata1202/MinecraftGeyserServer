FILE="server.properties"

sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "$FILE"
sed -i 's/difficulty=easy/difficulty=normal/' "$FILE"
