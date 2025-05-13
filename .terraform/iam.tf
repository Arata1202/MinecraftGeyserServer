resource "aws_iam_role" "minecraft_s3_role" {
  name = "minecraft_s3_role"

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

resource "aws_iam_policy" "minecraft_s3_put_only_policy" {
  name = "minecraft_s3_put_only_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:PutObject",
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "minecraft_s3_put_only_attachment" {
  role       = aws_iam_role.minecraft_s3_role.name
  policy_arn = aws_iam_policy.minecraft_s3_put_only_policy.arn
}

resource "aws_iam_instance_profile" "minecraft_instance_profile" {
  name = "minecraft_instance_profile"
  role = aws_iam_role.minecraft_s3_role.name
}

resource "aws_iam_role" "minecraft_lambda_role" {
  name = "minecraft_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "minecraft_lambda_policy" {
  name = "minecraft_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:DescribeInstances"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_ec2_policy_attach" {
  role       = aws_iam_role.minecraft_lambda_role.name
  policy_arn = aws_iam_policy.minecraft_lambda_policy.arn
}
