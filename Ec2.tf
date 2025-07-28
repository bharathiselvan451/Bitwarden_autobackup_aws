resource "aws_iam_instance_profile" "ec2tos3_bitwarden" {
  name = "ec2tos3_bitwarden"
  role = aws_iam_role.ec2tos3_bitwarden_role.name
}

resource "aws_iam_role" "ec2tos3_bitwarden_role" {
  name               = "ec2tos3_bitwarden_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment_s3" {
  role       = aws_iam_role.ec2tos3_bitwarden_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# You can attach multiple policies similarly
resource "aws_iam_role_policy_attachment" "role_policy_attachment_ec2" {
  role       = aws_iam_role.ec2tos3_bitwarden_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

