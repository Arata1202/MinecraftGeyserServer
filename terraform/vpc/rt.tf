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
