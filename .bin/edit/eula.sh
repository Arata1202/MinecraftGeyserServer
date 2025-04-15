FILE="eula.txt"

if [ -f "$FILE" ]; then
  echo "Updating $FILE..."
  sed -i 's/eula=false/eula=true/' "$FILE"
  echo "Done."
else
  echo "$FILE not found!"
fi
