output "vpc_id" {
  value = aws_vpc.minecraft_vpc.id
}

output "public_subnet_1_id" {
  value = aws_subnet.minecraft_public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.minecraft_public_subnet_2.id
}
