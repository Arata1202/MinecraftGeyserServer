data "archive_file" "minecraft_lambda_stop" {
  type        = "zip"
  source_file = "../lambda/stop.py"
  output_path = "../lambda/zip/stop.zip"
}

resource "aws_lambda_function" "minecraft_lambda_stop" {
  function_name    = "minecraft_lambda_stop"
  filename         = data.archive_file.minecraft_lambda_stop.output_path
  source_code_hash = data.archive_file.minecraft_lambda_stop.output_base64sha256
  runtime          = "python3.9"
  role             = aws_iam_role.minecraft_lambda_role.arn
  handler          = "stop.lambda_handler"
  timeout          = 300

  environment {
    variables = {
      INSTANCE_ID = var.instance_id
      WEBHOOK_URL = var.discord_webhook_url
    }
  }
}
