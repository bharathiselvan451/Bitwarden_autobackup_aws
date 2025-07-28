resource "aws_iam_role" "lambda_create_ec2" {

    name = "lambda_create_ec2"
    assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
  
}

resource "aws_iam_role_policy_attachment" "lambda_policy_1" {
  role       = aws_iam_role.lambda_create_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_2" {
  role       = aws_iam_role.lambda_create_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

data "archive_file" "lambda_file" {
  type        = "zip"
  source_file = "launch_ec2.py"
  output_path = "launch_ec2.zip"
}

resource "aws_lambda_function" "lambda_1" {
  function_name    = "launch_ec2"
  handler          = "launch_ec2.lambda_handler"
  runtime          = "python3.13"
  filename         = "launch_ec2.zip"
  source_code_hash = data.archive_file.lambda_file.output_base64sha256
  role             = aws_iam_role.lambda_create_ec2.arn
  timeout = 300

  
  environment {
    variables = {
      ec2_role = aws_iam_role.ec2tos3_bitwarden_role.arn,
    }
  }
 

}

