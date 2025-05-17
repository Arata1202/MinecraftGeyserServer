data "archive_file" "minecraft_lambda_start" {
  type        = "zip"
  source_file = "../lambda/start.py"
  output_path = "../lambda/zip/start.zip"
}

resource "aws_lambda_function" "minecraft_lambda_start" {
  function_name    = "minecraft_lambda_start"
  filename         = data.archive_file.minecraft_lambda_start.output_path
  source_code_hash = data.archive_file.minecraft_lambda_start.output_base64sha256
  runtime          = "python3.9"
  role             = aws_iam_role.minecraft_lambda_role.arn
  handler          = "start.lambda_handler"
  timeout          = 300

  environment {
    variables = {
      INSTANCE_ID = var.instance_id
      WEBHOOK_URL = var.discord_webhook_url
    }
  }
}
