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

# Start server
make up
```

### Setup on AWS EC2

```bash
# Create Resources
make init
make plan
make apply

# Clone repository
git clone git@github.com:Arata1202/MinecraftGeyserServer.git
cd MinecraftGeyserServer

# Set up EC2
./.aws/ec2.sh

# Set up server
sudo make setup

# Start server
sudo make up
```
