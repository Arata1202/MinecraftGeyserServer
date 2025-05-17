module "lambda" {
  source = "./lambda"

  instance_id         = var.instance_id
  discord_webhook_url = var.discord_webhook_url
}

module "s3" {
  source = "./s3"

  bucket_name   = var.bucket_name
  iam_role_name = aws_iam_role.minecraft_s3_role.name
}
