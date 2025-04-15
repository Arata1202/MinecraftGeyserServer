FILE="server.properties"

if [ -f "$FILE" ]; then
  echo "Updating $FILE..."
  sed -i '' 's/enforce-secure-profile=true/enforce-secure-profile=false/' "$FILE"
  echo "Done."
else
  echo "$FILE not found!"
fi