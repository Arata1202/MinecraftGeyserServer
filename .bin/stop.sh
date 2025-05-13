mcrcon -H 127.0.0.1 -P 25575 -p minecraft stop

while pgrep -f "java.*Folia.jar" > /dev/null; do
  sleep 1
done
