resource "aws_iam_role" "minecraft_ec2_role" {
  name = "minecraft_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_instance_profile" "minecraft_instance_profile" {
  name = "minecraft_instance_profile"
  role = aws_iam_role.minecraft_ec2_role.name
}
