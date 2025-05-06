resource "aws_instance" "minecraft_server" {
  ami                         = "ami-026c39f4021df9abe"
  instance_type               = "t3a.medium"
  key_name                    = "minecraft_key"
  subnet_id                   = aws_subnet.minecraft_public_subnet_1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.minecraft_sg.id]

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
  }

  tags = {
    Name = "minecraft_server"
  }
}

resource "aws_security_group" "minecraft_sg" {
  name        = "minecraft_sg"
  description = "minecraft_sg"
  vpc_id      = aws_vpc.minecraft_vpc.id

  ingress {
    from_port   = 25565
    to_port     = 25565
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 19132
    to_port     = 19132
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_sg"
  }
}
