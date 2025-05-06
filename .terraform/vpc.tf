data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "minecraft_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "minecraft_vpc"
  }
}

resource "aws_internet_gateway" "minecraft_igw" {
  vpc_id = aws_vpc.minecraft_vpc.id

  tags = {
    Name = "minecraft_igw"
  }
}

resource "aws_subnet" "minecraft_public_subnet_1" {
  vpc_id                  = aws_vpc.minecraft_vpc.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = data.aws_availability_zones.available.names[0]
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
  availability_zone = data.aws_availability_zones.available.names[0]

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

resource "aws_route_table" "minecraft_route_table" {
  vpc_id = aws_vpc.minecraft_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.minecraft_igw.id
  }

  tags = {
    Name = "minecraft_route_table"
  }
}

resource "aws_route_table_association" "minecraft_public_subnet_1" {
  subnet_id      = aws_subnet.minecraft_public_subnet_1.id
  route_table_id = aws_route_table.minecraft_route_table.id
}

resource "aws_route_table_association" "minecraft_public_subnet_2" {
  subnet_id      = aws_subnet.minecraft_public_subnet_2.id
  route_table_id = aws_route_table.minecraft_route_table.id
}
