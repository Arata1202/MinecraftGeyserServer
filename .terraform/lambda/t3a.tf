data "archive_file" "minecraft_lambda_t3a" {
  type        = "zip"
  source_file = "../lambda/t3a.py"
  output_path = "../lambda/zip/t3a.zip"
}

resource "aws_lambda_function" "minecraft_lambda_t3a" {
  function_name    = "minecraft_lambda_t3a"
  filename         = data.archive_file.minecraft_lambda_t3a.output_path
  source_code_hash = data.archive_file.minecraft_lambda_t3a.output_base64sha256
  runtime          = "python3.9"
  role             = aws_iam_role.minecraft_lambda_role.arn
  handler          = "t3a.lambda_handler"
  timeout          = 900

  environment {
    variables = {
      INSTANCE_ID = var.instance_id
      WEBHOOK_URL = var.discord_webhook_url
    }
  }
}
