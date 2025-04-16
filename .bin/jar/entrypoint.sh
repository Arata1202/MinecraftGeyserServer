if [ ! -f "./Paper.jar" ]; then
  ./.bin/jar/cmd/floodgate.sh
  ./.bin/jar/cmd/geyser.sh
  ./.bin/jar/cmd/paper.sh
  ./.bin/jar/cmd/via-version.sh

  make reboot
  sleep 10
fi