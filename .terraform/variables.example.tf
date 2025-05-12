variable "region" {
  default = "ap-northeast-1"
}

variable "ami" {
  default = "ami-038e94aea55c0f480"
}

variable "instance_type" {
  default = "c8g.large"
}

variable "key_name" {
  default = "minecraft_key"
}

variable "volume_type" {
  default = "gp3"
}

variable "volume_size" {
  default = "8"
}

variable "bucket_name" {
  default = "minecraft_s3"
}
