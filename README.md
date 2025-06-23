<div align="right">

![GitHub License](https://img.shields.io/github/license/Arata1202/MinecraftGeyserServer)

</div>

# Minecraft Geyser Server on AWS

This guide provides instructions for setting up and managing a Minecraft Geyser server on AWS. Geyser allows Minecraft Bedrock Edition clients to connect to Minecraft Java Edition servers.

## Table of Contents

1.  [Initial Setup](#initial-setup)
    *   [Prerequisites](#prerequisites)
    *   [1.1. Create AWS Resources with Terraform (Local Machine)](#11-create-aws-resources-with-terraform-local-machine)
    *   [1.2. Set Up Minecraft Server (EC2 Instance)](#12-set-up-minecraft-server-ec2-instance)
2.  [Server Configuration](#server-configuration)
    *   [2.1. Configure Nginx and Obtain SSL Certificate for Dynmap (EC2 Instance)](#21-configure-nginx-and-obtain-ssl-certificate-for-dynmap-ec2-instance)
    *   [2.2. Set Up Basic Authentication for Nginx (EC2 Instance)](#22-set-up-basic-authentication-for-nginx-ec2-instance)
    *   [2.3. Manage Minecraft Server Whitelist (EC2 Instance)](#23-manage-minecraft-server-whitelist-ec2-instance)
    *   [2.4. Set Up Auto Shutdown Batch (EC2 Instance)](#24-set-up-auto-shutdown-batch-ec2-instance)
3.  [World Management](#world-management)
    *   [3.1. Upload Existing World (Local Machine to EC2)](#31-upload-existing-world-local-machine-to-ec2)
4.  [Server Maintenance](#server-maintenance)
    *   [4.1. EC2 Server Maintenance Tasks](#41-ec2-server-maintenance-tasks)

---

## Initial Setup

This section covers the initial steps to get your AWS infrastructure and Minecraft server up and running.

### Prerequisites

*   An AWS account.
*   Terraform installed on your local machine.
*   Git installed on your local machine.

### 1.1. Create AWS Resources with Terraform (Local Machine)

These steps will guide you through provisioning the necessary AWS (Amazon Web Services) resources, such as EC2 (Elastic Compute Cloud) instances and security groups, using Terraform. Terraform is an "infrastructure-as-code" tool that allows you to define and manage your cloud resources programmatically.

```bash
# Clone this repository to your local machine
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer/.terraform

# Prepare and customize the Terraform variables file
# This file contains settings like your desired AWS region, instance types, etc.
mv variables.example.tf variables.tf
vi variables.tf  # Edit this file with your specific parameters

# Initialize Terraform (downloads necessary providers)
terraform init

# Preview the resources Terraform will create
terraform plan

# Apply the Terraform configuration to create the resources on AWS
terraform apply
```

### 1.2. Set Up Minecraft Server (EC2 Instance)

Once the AWS resources (including your EC2 instance) are created by Terraform, you need to connect to the EC2 instance via SSH (Secure Shell) and set up the Minecraft server software. This involves cloning the repository again (this time, onto the EC2 instance) and using Docker and Docker Compose to run the server.

```bash
# SSH into your newly created EC2 instance.
# The IP address or DNS name can be found in the Terraform output or AWS console.

# Clone the repository onto the EC2 instance
git clone https://github.com/Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Prepare and customize the environment variables file for the server
# This file includes settings like server name, RCON password, etc.
cp .env.example .env
vi .env # Edit this file with your server settings

# Run the Linux setup script (e.g., installs Docker, Docker Compose)
./.linux/setup.sh

# Set up the Minecraft server using Docker Compose
# This command builds the Docker images and sets up initial configurations.
sudo make setup

# Start the Minecraft server
sudo make up

# To stop the Minecraft server
# sudo make down
```

---

## Server Configuration

This section details how to configure various aspects of your Minecraft server, including web access, security, and player management.

### 2.1. Configure Nginx and Obtain SSL Certificate for Dynmap (EC2 Instance)

Dynmap is a popular plugin that generates a real-time, web-accessible map of your Minecraft world. These instructions explain how to set up Nginx (a web server and reverse proxy) to serve Dynmap over HTTPS. This involves obtaining a free SSL/TLS certificate from Let's Encrypt to encrypt the traffic.

**Prerequisites:**
*   Your Minecraft server should be running (`sudo make up`).
*   You must have a Fully Qualified Domain Name (FQDN) (e.g., `dynmap.yourdomain.com`) that resolves to your EC2 instance's public IP address. You'll need to configure this with your DNS provider.

```bash
# Ensure the server is running
# sudo make up

# Edit Nginx configuration files to set your FQDN
# Replace <YOUR_FQDN> with your actual domain name.
vi ./.docker/nginx/default.conf
vi ./.docker/nginx/ssl_server.conf.txt

# Temporarily switch to the HTTP Nginx configuration to allow Let's Encrypt to verify domain ownership
mv ./.docker/nginx/default.conf ./.docker/nginx/default.conf.txt
mv ./.docker/nginx/ssl_server.conf.txt ./.docker/nginx/default.conf

# Obtain the SSL certificate using Certbot (Let's Encrypt client)
# Replace <YOUR_FQDN> with your FQDN.
sudo docker compose run --rm certbot certonly --webroot -w /var/www/html -d <YOUR_FQDN>

# Revert to the HTTPS (SSL-enabled) Nginx configuration
mv ./.docker/nginx/default.conf ./.docker/nginx/ssl_server.conf.txt
mv ./.docker/nginx/default.conf.txt ./.docker/nginx/default.conf

# Reload Nginx to apply the new configuration and SSL certificate
sudo docker compose exec nginx nginx -s reload
```

### 2.2. Set Up Basic Authentication for Nginx (EC2 Instance)

To add a layer of security and restrict access to your Dynmap (or any other content served by Nginx), you can enable HTTP Basic Authentication. This will prompt users for a username and password before they can access the site.

**Prerequisites:**
*   Nginx should be configured and running (as per step 2.1).
*   Your Minecraft server should be running (`sudo make up`).

```bash
# Ensure the server is running
# sudo make up

# Create a .htpasswd file and add a user for Basic Authentication
# Replace <YOUR_USER_NAME> with your desired username. You will be prompted to set a password.
sudo docker compose exec nginx htpasswd -c /etc/nginx/.htpasswd <YOUR_USER_NAME>

# Reload Nginx to apply the Basic Authentication settings
sudo docker compose exec nginx nginx -s reload
```

### 2.3. Manage Minecraft Server Whitelist (EC2 Instance)

A whitelist is a security feature that allows only explicitly approved players to join your Minecraft server. This is highly recommended for private servers to prevent unauthorized access. Management is done via RCON (Remote Console).

**Prerequisites:**
*   Your Minecraft server should be running (`sudo make up`) for adding/removing/listing players.
*   You will need the RCON password that you set in your `.env` file during the server setup (Step 1.2).

```bash
# Stop the server to safely edit server.properties
sudo make down

# Enable the whitelist feature in server.properties
sed -i 's/white-list=false/white-list=true/' server.properties

# Start the server
sudo make up

# Add a player to the whitelist
# Replace <RCON_PASSWORD> with your RCON password and <PLAYER_NAME> with the Minecraft username.
sudo docker compose exec minecraft mcrcon -H 127.0.0.1 -P 25575 -p <RCON_PASSWORD> "whitelist add <PLAYER_NAME>"

# Remove a player from the whitelist
sudo docker compose exec minecraft mcrcon -H 127.0.0.1 -P 25575 -p <RCON_PASSWORD> "whitelist remove <PLAYER_NAME>"

# View the list of whitelisted players
sudo docker compose exec minecraft mcrcon -H 127.0.0.1 -P 25575 -p <RCON_PASSWORD> "whitelist list"
```

### 2.4. Set Up Auto Shutdown Script (EC2 Instance)

To help manage costs, especially on cloud platforms like AWS, you can set up an automated script that checks if players are online and shuts down the Minecraft server if it's empty for a certain period. This is typically done using a cron job that runs a script at regular intervals. The `cron.sh` script in this repository is designed for this purpose.

**Note:** The specific logic for checking player count and shutdown conditions is within the `.bin/cron.sh` script. You may need to adjust it to your preferences.

```bash
# Create a log file for the cron job
touch logs/cron.log

# Add a cron job that runs the .bin/cron.sh script every 10 minutes
# The script's output and errors will be logged to logs/cron.log
( sudo crontab -l 2>/dev/null; echo "*/10 * * * * /home/ubuntu/MinecraftGeyserServer/.bin/cron.sh >> /home/ubuntu/MinecraftGeyserServer/logs/cron.log 2>&1" ) | sudo crontab -
```

---

## World Management

Instructions for managing your Minecraft world data.

### 3.1. Upload Existing World (Local Machine to EC2)

If you have a pre-existing Minecraft Java Edition world that you want to use on your new server, these steps explain how to upload it from your local computer to the EC2 instance.

**Important Considerations:**
*   **Backup:** Always back up your existing world data before performing this operation.
*   **Overwrite:** This process will overwrite any world data currently on the EC2 server in the target directories.
*   **World Folders:** A standard Minecraft Java Edition world typically consists of three main folders:
    *   `world`: The main Overworld data.
    *   `world_nether`: The Nether dimension data.
    *   `world_the_end`: The End dimension data.
    Ensure your world data is structured this way in the `uploads/` directory.

```bash
# On your local machine:

# Clone the repository (if you haven't already)
# git clone git@github.com:Arata1202/MinecraftGeyserServer.git
# cd MinecraftGeyserServer

# Prepare and edit the .env file with your EC2 instance details (e.g., SSH key, IP address)
# This is needed for the `make upload` command to connect to your server.
cp .env.example .env
vi .env

# Place your world data into the 'uploads' directory
# The world usually consists of three folders: world, world_nether, and world_the_end.
mv <path/to/your/world> uploads/world
mv <path/to/your/world_nether> uploads/world_nether
mv <path/to/your/world_the_end> uploads/world_the_end

# Upload the world data to the EC2 server
# This command uses rsync or scp (defined in the Makefile) to transfer the files.
make upload
```
**Note:** After uploading, you might need to restart the Minecraft server on the EC2 instance for the changes to take effect: `sudo make down && sudo make up`.

---

## Server Maintenance

This section provides commands for routine maintenance of your EC2 server to ensure it runs smoothly and to manage resources effectively.

### 4.1. EC2 Server Maintenance Tasks

```bash
# Check EBS (Elastic Block Store) disk usage on the EC2 instance
df -h

# Remove unused Docker builder cache to free up disk space
sudo docker builder prune -f
```
