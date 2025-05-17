resource "aws_s3_bucket" "minecraft_s3" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_public_access_block" "minecraft_bpa" {
  bucket                  = aws_s3_bucket.minecraft_s3.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
