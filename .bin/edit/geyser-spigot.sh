FILE="plugins/Geyser-Spigot/config.yml"

if [ -f "$FILE" ]; then
  if grep -q "auth-type: online" "$FILE"; then
    sed -i 's/auth-type: online/auth-type: floodgate/' "$FILE"
  fi
fi
