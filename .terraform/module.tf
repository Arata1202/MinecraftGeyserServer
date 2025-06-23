module "vpc" {
  source = "./vpc"
}

module "ec2" {
  source = "./ec2"

  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  volume_type   = var.volume_type
  volume_size   = var.volume_size
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_1_id
}

module "lambda" {
  source = "./lambda"

  instance_id         = var.instance_id
  discord_webhook_url = var.discord_webhook_url
}

module "s3" {
  source = "./s3"

  bucket_name   = var.bucket_name
  iam_role_name = module.ec2.iam_role_name
}

module "ssm" {
  source = "./ssm"

  iam_role_name = module.ec2.iam_role_name
}

module "route53" {
  source = "./route53"

  hosted_zone_id = var.hosted_zone_id
  iam_role_name  = module.ec2.iam_role_name
}

module "iam" {
  source = "./iam"

  s3_bucket_name  = var.bucket_name
  route53_zone_id = var.hosted_zone_id
}
