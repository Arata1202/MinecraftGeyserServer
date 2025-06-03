sudo apt update
sudo apt install -y ca-certificates curl gnupg make git gcc unzip python3 python3-pip apache2-utils
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc > /dev/null
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
git clone https://github.com/Tiiffi/mcrcon.git
cd mcrcon
make
sudo cp mcrcon /usr/local/bin
curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
chmod +x /home/ubuntu/MinecraftGeyserServer/.bin/active.sh
(crontab -l 2>/dev/null | grep -v 'active.sh'; echo "*/10 * * * * /home/ubuntu/MinecraftGeyserServer/.bin/active.sh") | crontab -
