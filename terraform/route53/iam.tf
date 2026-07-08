resource "aws_iam_policy" "route53_change_record_policy" {
  name = "route53_change_record_policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "VisualEditor0",
        Effect   = "Allow",
        Action   = "route53:ChangeResourceRecordSets",
        Resource = "arn:aws:route53:::hostedzone/${var.hosted_zone_id}"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "route53_policy_attachment" {
  role       = var.iam_role_name
  policy_arn = aws_iam_policy.route53_change_record_policy.arn
}
