output "iam_role_name" {
  value = aws_iam_role.minecraft_ec2_role.name
}

output "instance_id" {
  value = aws_instance.minecraft_server.id
}
