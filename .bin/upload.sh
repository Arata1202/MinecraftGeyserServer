set -a
source .env
set +a

if [ -d "./uploads/world" ]; then
    ssh -i $KEY_PATH ubuntu@$IP_ADDRESS 'sudo rm -rf /home/ubuntu/MinecraftGeyserServer/world' && \
    scp -i $KEY_PATH -r ./uploads/world ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/ && \
    rm -rf ./uploads/world
fi

if [ -d "./uploads/world_nether" ]; then
    ssh -i $KEY_PATH ubuntu@$IP_ADDRESS 'sudo rm -rf /home/ubuntu/MinecraftGeyserServer/world_nether' && \
    scp -i $KEY_PATH -r ./uploads/world_nether ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/ && \
    rm -rf ./uploads/world_nether
fi

if [ -d "./uploads/world_the_end" ]; then
    ssh -i $KEY_PATH ubuntu@$IP_ADDRESS 'sudo rm -rf /home/ubuntu/MinecraftGeyserServer/world_the_end' && \
    scp -i $KEY_PATH -r ./uploads/world_the_end ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/ && \
    rm -rf ./uploads/world_the_end
fi

if [ -f "./uploads/server.properties" ]; then
    ssh -i $KEY_PATH ubuntu@$IP_ADDRESS 'sudo rm /home/ubuntu/MinecraftGeyserServer/server.properties' && \
    scp -i $KEY_PATH -r ./uploads/server.properties ubuntu@$IP_ADDRESS:/home/ubuntu/MinecraftGeyserServer/ && \
    rm ./uploads/server.properties
fi
