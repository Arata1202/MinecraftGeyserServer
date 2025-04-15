VERSION=1.20.4

BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/${VERSION}" | jq -r '.builds[-1]')

curl -o Paper.jar \
  "https://api.papermc.io/v2/projects/paper/versions/${VERSION}/builds/${BUILD}/downloads/paper-${VERSION}-${BUILD}.jar"
