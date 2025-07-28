provider "aws" {

   profile = "default"
   region = "us-east-1"

   

}
resource "aws_s3_bucket" "bucket" {

    bucket = "bitwarden-backup-monthly"

    lifecycle_rule {
    id     = "delete-old-files"
    enabled = true
    # Optional: Apply rule to objects with this prefix

    expiration {
      days = 90 # Delete objects older than 30 days
    }
  }
  
}

resource "aws_s3_bucket_policy" "bitwardenbackup_bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": aws_iam_role.ec2tos3_bitwarden_role.arn
            },
            "Action": [
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::bitwarden-backup-monthly/*"
        }
    ]
})
}

