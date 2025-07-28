resource "aws_s3_bucket_notification" "my-trigger" {
    bucket = aws_s3_bucket.bucket.id

    lambda_function {
        lambda_function_arn = aws_lambda_function.lambda_2.arn
        events              = ["s3:ObjectCreated:*"]
        filter_suffix       = ".json"
    }
}



resource "aws_lambda_permission" "trigger-permission" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_2.arn
  principal = "s3.amazonaws.com"
  source_arn = "arn:aws:s3:::bitwarden-backup-monthly"
}