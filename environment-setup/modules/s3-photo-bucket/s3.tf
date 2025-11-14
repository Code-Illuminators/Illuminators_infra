resource "aws_s3_bucket" "birdwatching_photo_bucket" {
  bucket = "birdwatching-photo-bucket-${var.env}"
}

resource "aws_s3_bucket" "birdwatching_photo_bucket_logs" {
  bucket = "birdwatching-photo-logs-${var.env}"
}

data "aws_iam_policy_document" "birdwatching_photo_bucket_logs" {
  statement {
    sid    = "s3-log-delivery"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = [
      "${aws_s3_bucket.birdwatching_photo_bucket_logs.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "birdwatching_photo_bucket_logs" {
  bucket = aws_s3_bucket.birdwatching_photo_bucket_logs.id
  policy = data.aws_iam_policy_document.birdwatching_photo_bucket_logs.json
}

resource "aws_s3_bucket_logging" "birdwatching_photo_bucket" {
  bucket = aws_s3_bucket.birdwatching_photo_bucket.id

  target_bucket = aws_s3_bucket.birdwatching_photo_bucket_logs.id
  target_prefix = "access-logs/"
}

resource "aws_s3_bucket_public_access_block" "birdwatching_photo_bucket" {
  bucket = aws_s3_bucket.birdwatching_photo_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "birdwatching_photo_bucket_https_only" {
  bucket = aws_s3_bucket.birdwatching_photo_bucket.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyInsecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.birdwatching_photo_bucket.arn,
          "${aws_s3_bucket.birdwatching_photo_bucket.arn}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}