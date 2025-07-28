resource "aws_cloudwatch_event_rule" "s3_object_created_rule" {
  name        = "s3-object-created-rule"
  description = "Rule to trigger on object creation in S3"

  event_pattern = jsonencode({
    source = ["aws.s3"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventSource = ["s3.amazonaws.com"]
      eventName = ["PutObject"]
       
    }
  })
}

resource "aws_cloudwatch_event_target" "s3_object_created_target" {
  rule      = aws_cloudwatch_event_rule.s3_object_created_rule.name
  target_id = "delete_ec2_lambda"
  arn       = aws_lambda_function.lambda_2.arn # Replace with your SQS queue ARN
}

resource "aws_lambda_permission" "allow_cloudwatch_2" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_2.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_object_created_rule.arn
}