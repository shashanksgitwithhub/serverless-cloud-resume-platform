resource "aws_dynamodb_table" "visitor_counter" {
  name         = "cloud-resume-visitor-counter"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_iam_role" "lambda_execution" {
  name        = "CloudResumeLambdaExecutionRole"
  description = "Allows Lambda functions to call AWS services on your behalf."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "lambda.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_dynamodb" {
  name = "CloudResumeDynamoDBUpdate"
  role = aws_iam_role.lambda_execution.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "dynamodb:UpdateItem"
        ]

        Resource = aws_dynamodb_table.visitor_counter.arn
      }
    ]
  })
}

resource "aws_lambda_function" "visitor_counter" {
  function_name = "cloud-resume-visitor-counter"

  role = aws_iam_role.lambda_execution.arn

  runtime = "python3.13"
  handler = "lambda_function.lambda_handler"

  filename         = "../backend/lambda.zip"
  source_code_hash = filebase64sha256("../backend/lambda.zip")

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.visitor_counter.name
    }
  }
}

resource "aws_apigatewayv2_api" "resume_api" {
  name          = "Cloud_resume_API"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["https://shashanktj.com"]
    allow_methods = ["POST"]
    allow_headers = ["content-type"]
  }
}

resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id = aws_apigatewayv2_api.resume_api.id

  integration_type   = "AWS_PROXY"
  integration_method = "POST"

  integration_uri = aws_lambda_function.visitor_counter.arn

  payload_format_version = "2.0"
  timeout_milliseconds   = 30000
}

resource "aws_apigatewayv2_route" "visitor_route" {
  api_id    = aws_apigatewayv2_api.resume_api.id
  route_key = "POST /visitors"

  target = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id      = aws_apigatewayv2_api.resume_api.id
  name        = "$default"
  auto_deploy = true
}