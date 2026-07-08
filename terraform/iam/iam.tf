resource "aws_iam_user" "minecraft_iam_user" {
  name = "minecraft_iam_user"
}

resource "aws_iam_policy" "s3_backup_policy" {
  name = "s3_backup_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "route53_dns_policy" {
  name = "route53_dns_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:GetChange",
          "route53:ListResourceRecordSets"
        ]
        Resource = [
          "arn:aws:route53:::hostedzone/${var.route53_zone_id}",
          "arn:aws:route53:::change/*"
        ]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:GetHostedZone"
        ]
        Resource = "arn:aws:route53:::hostedzone/${var.route53_zone_id}"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "minecraft_iam_user_s3_backup" {
  user       = aws_iam_user.minecraft_iam_user.name
  policy_arn = aws_iam_policy.s3_backup_policy.arn
}

resource "aws_iam_user_policy_attachment" "minecraft_iam_user_route53_dns" {
  user       = aws_iam_user.minecraft_iam_user.name
  policy_arn = aws_iam_policy.route53_dns_policy.arn
}
