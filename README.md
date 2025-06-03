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

# Create Resources
terraform init
terraform plan
terraform apply
```

### Setup on AWS EC2

```bash
# Clone repository
git clone https://github.com/Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Prepare and edit .env file (set BUCKET_NAME, ROUTE53_ZONEID, ROUTE53_FQDN, LAMBDA_STOP_URL)
mv .env.example .env
vi .env

# Set up EC2
./.aws/ec2.sh

# Set up server
sudo make setup

# Edit the DiscordSRV configuration (set BotToken, Channels, DiscordConsoleChannelId, DiscordInviteLink)
# https://github.com/DiscordSRV/DiscordSRV/tree/master/src/main/resources/messages
sudo vi ./plugins/DiscordSRV/config.yml
sudo vi ./plugins/DiscordSRV/messages.yml

# Start server
sudo make up

# Add Players to Whitelist
mcrcon -H 127.0.0.1 -P 25575 -p minecraft "whitelist add <PLAYER_NAME>"

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
htpasswd -c /etc/nginx/.htpasswd <USER_NAME>

# Reload Nginx
sudo docker compose exec nginx nginx -s reload

# Stop server
sudo make down
```

### Upload Existing World

```bash
# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Prepare and edit .env file (set KEY_PATH, IP_ADDRESS)
mv .env.example .env
vi .env

# Prepare world data
mv world uploads/
mv world_nether uploads/
mv world_the_end uploads/

# Upload data
make upload
```
