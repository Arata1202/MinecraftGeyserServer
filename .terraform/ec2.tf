resource "aws_instance" "minecraft_server" {
  ami           = "ami-026c39f4021df9abe"
  instance_type = "t3a.medium"
  key_name      = "minecraft_key"

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
  }

  tags = {
    Name = "minecraft_server"
  }
}
