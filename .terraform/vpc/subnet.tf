resource "aws_subnet" "minecraft_public_subnet_1" {
  vpc_id                  = aws_vpc.minecraft_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "minecraft_public_subnet_1"
  }
}

resource "aws_subnet" "minecraft_public_subnet_2" {
  vpc_id                  = aws_vpc.minecraft_vpc.id
  cidr_block              = "10.0.16.0/20"
  availability_zone       = "ap-northeast-1d"
  map_public_ip_on_launch = true

  tags = {
    Name = "minecraft_public_subnet_2"
  }
}

resource "aws_subnet" "minecraft_private_subnet_1" {
  vpc_id            = aws_vpc.minecraft_vpc.id
  cidr_block        = "10.0.128.0/20"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "minecraft_private_subnet_1"
  }
}

resource "aws_subnet" "minecraft_private_subnet_2" {
  vpc_id            = aws_vpc.minecraft_vpc.id
  cidr_block        = "10.0.144.0/20"
  availability_zone = "ap-northeast-1d"

  tags = {
    Name = "minecraft_private_subnet_2"
  }
}
