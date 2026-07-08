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
  role       = var.iam_role_name
  policy_arn = aws_iam_policy.minecraft_s3_put_only_policy.arn
}
