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

# Prepare and edit .env file (set BUCKET_NAME, ROUTE53_ZONEID, ROUTE53_FQDN)
mv .env.example .env
vi .env

# Set up EC2
./.aws/ec2.sh

# Set up server
sudo make setup

# Edit the DiscordSRV configuration
sudo vi ./plugins/DiscordSRV/config.yml
sudo vi ./plugins/DiscordSRV/messages.yml

# Start server
sudo make up

# View logs
sudo make logs

# Stop server
sudo make down
```

### Upload Existing World

```bash
# Clone repository
git clone https://github.com/Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Prepare and edit .env file (set KEY_PATH, IP_ADDRESS)
mv .env.example .env
vi .env

# Prepare world data
mv world upload/
mv world_nether upload/
mv world_the_end upload/

# Upload data
make upload
```
