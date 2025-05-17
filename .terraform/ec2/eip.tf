# resource "aws_eip" "minecraft_eip" {
#   domain = "vpc"
#   tags = {
#     Name = "minecraft_eip"
#   }
# }

# resource "aws_eip_association" "minecraft_eip_association" {
#   instance_id   = aws_instance.minecraft_server.id
#   allocation_id = aws_eip.minecraft_eip.id
# }
