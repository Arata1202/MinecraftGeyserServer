FILE="eula.txt"

if [ -f "$FILE" ]; then
  sed -i 's/eula=false/eula=true/' "$FILE"
fi
