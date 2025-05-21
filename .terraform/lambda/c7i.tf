data "archive_file" "minecraft_lambda_c7i" {
  type        = "zip"
  source_file = "../lambda/c7i.py"
  output_path = "../lambda/zip/c7i.zip"
}

resource "aws_lambda_function" "minecraft_lambda_c7i" {
  function_name    = "minecraft_lambda_c7i"
  filename         = data.archive_file.minecraft_lambda_c7i.output_path
  source_code_hash = data.archive_file.minecraft_lambda_c7i.output_base64sha256
  runtime          = "python3.9"
  role             = aws_iam_role.minecraft_lambda_role.arn
  handler          = "c7i.lambda_handler"
  timeout          = 900

  environment {
    variables = {
      INSTANCE_ID = var.instance_id
      WEBHOOK_URL = var.discord_webhook_url
    }
  }
}
