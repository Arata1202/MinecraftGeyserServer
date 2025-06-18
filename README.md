<div align="right">

![GitHub License](https://img.shields.io/github/license/Arata1202/MinecraftGeyserServer)

</div>

## Getting Started

### Create Resources on AWS EC2 with Terraform

```bash
# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer/.terraform

# Prepare and edit variables file
mv variables.example.tf variables.tf
vi variables.tf

# Create resources
terraform init
terraform plan
terraform apply
```

### Setup on AWS EC2

```bash
# Clone repository
git clone https://github.com/Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Prepare and edit .env file
cp .env.example .env
vi .env

# Set up Linux
./.linux/setup.sh

# Set up server
sudo make setup

# Edit the DiscordSRV configuration (set BotToken, Channels, DiscordConsoleChannelId, DiscordInviteLink)
# https://github.com/DiscordSRV/DiscordSRV/tree/master/src/main/resources/messages
sudo vi ./plugins/DiscordSRV/config.yml
sudo vi ./plugins/DiscordSRV/messages.yml

# Edit the MOTD settings and upload a server icon
sudo vi ./plugins/MOTD/config.yml
mv server-icon.png ./plugins/MOTD/server icon/server-icon.png

# Start server
sudo make up

# Add players to whitelist
sudo docker compose exec minecraft mcrcon -H 127.0.0.1 -P 25575 -p <RCON_PASSWORD> "whitelist add <PLAYER_NAME>"

# Edit Nginx configuration files (set FQDN)
vi ./.docker/nginx/default.conf
vi ./.docker/nginx/ssl_server.conf.txt

# Switch to HTTP config temporarily for Let's Encrypt certificate issuance
mv ./.docker/nginx/default.conf ./.docker/nginx/default.conf.txt
mv ./.docker/nginx/ssl_server.conf.txt ./.docker/nginx/default.conf

# Obtain SSL certificate with Let's Encrypt
sudo docker compose run --rm certbot certonly --webroot -w /var/www/html -d <FQDN>

# Revert back to HTTPS (SSL-enabled) nginx configuration
mv ./.docker/nginx/default.conf ./.docker/nginx/ssl_server.conf.txt
mv ./.docker/nginx/default.conf.txt ./.docker/nginx/default.conf

# Create a new .htpasswd file and add a user for Basic Authentication
sudo docker compose exec nginx htpasswd -c /etc/nginx/.htpasswd <USER_NAME>

# Reload Nginx
sudo docker compose exec nginx nginx -s reload

# Set up cron
touch logs/cron.log
( sudo crontab -l 2>/dev/null; echo "*/10 * * * * /home/ubuntu/MinecraftGeyserServer/.bin/cron.sh >> /home/ubuntu/MinecraftGeyserServer/logs/cron.log 2>&1" ) | sudo crontab -

# Stop server
sudo make down
```

### Upload Existing World

```bash
# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Prepare and edit .env file
cp .env.example .env
vi .env

# Prepare world data
mv world uploads/
mv world_nether uploads/
mv world_the_end uploads/

# Upload data
make upload
```

### Maintenance

```bash
# Check EBS disk usage
df -h

# Remove unused Docker builder cache
sudo docker builder prune -f
```
