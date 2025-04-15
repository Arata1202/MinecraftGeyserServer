FILE="eula.txt"

if [ -f "$FILE" ]; then
  if grep -q "eula=false" "$FILE"; then
    sed -i 's/eula=false/eula=true/' "$FILE"
    sleep 10
  fi
fi
