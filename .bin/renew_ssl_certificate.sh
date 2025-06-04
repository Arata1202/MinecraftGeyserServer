cd /home/ubuntu/MinecraftGeyserServer
sudo docker compose run --rm certbot renew
sudo docker compose exec -T nginx nginx -s reload
