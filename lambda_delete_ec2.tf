resource "aws_iam_role" "lambda_delete_ec2" {

    name = "lambda_delete_ec2"
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

resource "aws_iam_role_policy_attachment" "lambda_policy_3" {
  role       = aws_iam_role.lambda_delete_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "lambda_policy_4" {
  role       = aws_iam_role.lambda_delete_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}


data "archive_file" "lambda_file_2" {
  type        = "zip"
  source_file = "delete_ec2.py"
  output_path = "delete_ec2.zip"
}

resource "aws_lambda_function" "lambda_2" {
  function_name    = "delete_ec2"
  handler          = "delete_ec2.lambda_handler"
  runtime          = "python3.13"
  filename         = "delete_ec2.zip"
  source_code_hash = data.archive_file.lambda_file_2.output_base64sha256
  role             = aws_iam_role.lambda_delete_ec2.arn
  timeout = 100

  
 

}

