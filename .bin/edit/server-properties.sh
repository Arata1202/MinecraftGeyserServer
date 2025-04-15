FILE="server.properties"

if [ -f "$FILE" ]; then
  if grep -q "enforce-secure-profile=true" "$FILE"; then
    sed -i 's/enforce-secure-profile=true/enforce-secure-profile=false/' "$FILE"
  fi
fi
