if [ ! -f "./plugins/Via-Version.jar" ] && [ ! -f "./Via-Version.jar" ]; then
  curl -L -o Via-Version.jar \
    "https://api.spiget.org/v2/resources/19254/download"
fi
