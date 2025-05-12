resource "aws_instance" "minecraft_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.minecraft_public_subnet_1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.minecraft_sg.id]

  root_block_device {
    volume_type = var.volume_type
    volume_size = var.volume_size
  }

  tags = {
    Name = "minecraft_server"
  }
}

resource "aws_eip" "minecraft_eip" {
  domain = "vpc"
  tags = {
    Name = "minecraft_eip"
  }
}

resource "aws_eip_association" "minecraft_eip_association" {
  instance_id   = aws_instance.minecraft_server.id
  allocation_id = aws_eip.minecraft_eip.id
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "minecraft_sg"
  }
}
