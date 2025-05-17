resource "aws_iam_role_policy_attachment" "minecraft_ssm_attachment" {
  role       = var.iam_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
