resource "aws_s3_bucket" "birdwatching_photo_bucket" {
  bucket = "birdwatching-photo-bucket-${var.env}"
}
