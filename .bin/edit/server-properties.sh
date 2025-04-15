FILE="server.properties"

if [ -f "$FILE" ]; then
  sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "$FILE"
fi
