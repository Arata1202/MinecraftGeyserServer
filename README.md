<div align="right">

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/Arata1202/MinecraftGeyserServer/deploy.yml)
![GitHub License](https://img.shields.io/github/license/Arata1202/MinecraftGeyserServer)

</div>

## Getting Started

### Setup with Docker

```bash
# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Set up server
make setup
```

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
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Set up EC2
sudo make ec2

# Set up server
sudo make setup

# Start server
sudo make run
```
