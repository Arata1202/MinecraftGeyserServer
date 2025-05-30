set -a
source .env
set +a

if [ -d "./uploads/world" ]; then
    rsync -e "ssh -i $KEY_PATH" -az --delete ./uploads/world/ ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/world/
    rm -rf ./uploads/world
fi

if [ -d "./uploads/world_nether" ]; then
    rsync -e "ssh -i $KEY_PATH" -az --delete ./uploads/world_nether/ ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/world_nether/
    rm -rf ./uploads/world_nether
fi

if [ -d "./uploads/world_the_end" ]; then
    rsync -e "ssh -i $KEY_PATH" -az --delete ./uploads/world_the_end/ ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/world_the_end/
    rm -rf ./uploads/world_the_end
fi

if [ -f "./uploads/server.properties" ]; then
    rsync -e "ssh -i $KEY_PATH" -az ./uploads/server.properties ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/server.properties
    rm ./uploads/server.properties
fi
