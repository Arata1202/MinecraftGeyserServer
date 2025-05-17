module "lambda" {
  source = "./lambda"

  instance_id         = var.instance_id
  discord_webhook_url = var.discord_webhook_url
}
