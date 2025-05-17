resource "aws_instance" "minecraft_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.minecraft_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.minecraft_instance_profile.name

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  tags = {
    Name = "minecraft_server"
  }
}
