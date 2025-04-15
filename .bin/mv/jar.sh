if [ -f "./Floodgate-Spigot.jar" ] || [ -f "./Geyser-Spigot.jar" ] || [ -f "./Via-Version.jar" ]; then
    mv ./Floodgate-Spigot.jar plugins/
    mv ./Geyser-Spigot.jar plugins/
    mv ./Via-Version.jar plugins/

    sleep 10
    make reboot
    sleep 10
    make stop
fi