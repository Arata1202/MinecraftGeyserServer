FILE="plugins/Geyser-Spigot/config.yml"

if [ -f "$FILE" ]; then
  echo "Updating $FILE..."
  sed -i '' 's/auth-type: online/auth-type: floodgate/' "$FILE"
  echo "Done."
else
  echo "$FILE not found!"
fi