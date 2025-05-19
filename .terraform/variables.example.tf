variable "region" {
  default = "ap-northeast-1"
}

variable "ami" {
  default = "ami-026c39f4021df9abe" # x86_64
  # default = "ami-038e94aea55c0f480" # arm64
}

variable "instance_type" {
  default = "c7i.xlarge"
}

variable "key_name" {
  default = "minecraft_key"
}

variable "volume_type" {
  default = "gp3"
}

variable "volume_size" {
  default = "20"
}

variable "bucket_name" {
  default = "minecraft_s3"
}

variable "instance_id" {
  default = "i-xxxxxxxxxxxxxxxxxx"
}

variable "discord_webhook_url" {
  default = "https://discord.com/api/webhooks/xxx/yyy"
}

variable "hosted_zone_id" {
  default = "xxxxxxxxxx"
}
