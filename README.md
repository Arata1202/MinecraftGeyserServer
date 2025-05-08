<div align="right">

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/Arata1202/MinecraftGeyserServer/deploy.yml)
![GitHub License](https://img.shields.io/github/license/Arata1202/MinecraftGeyserServer)

</div>

## Getting Started

### Local Setup with Docker

```bash
# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Set up server
make setup

# Set up repository
sudo make git

# Start server
make up
```

### Create Resources on AWS EC2 with Terraform

```bash
# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer/.terraform

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

# Set up repository
sudo make git

# Start server
sudo make run
```
