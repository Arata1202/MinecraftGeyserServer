if [ ! -f "./plugins/Floodgate-Spigot.jar" ] && [ ! -f "./plugins/Geyser-Spigot.jar" ] && [ ! -f "./plugins/Via-Version.jar" ]; then
    mv ./Floodgate-Spigot.jar plugins/
    mv ./Geyser-Spigot.jar plugins/
    mv ./Via-Version.jar plugins/

    sleep 10
    make reboot
    sleep 10
    make stop
    sleep 10
fi