if [ ! -f "./Paper.jar" ]; then
  ./.bin/jar/cmd/floodgate.sh
  ./.bin/jar/cmd/geyser.sh
  ./.bin/jar/cmd/paper.sh
  ./.bin/jar/cmd/via-version.sh

  ./.bin/reboot.sh

  while [ ! -f "eula.txt" ]; do
    sleep 1
  done
fi
