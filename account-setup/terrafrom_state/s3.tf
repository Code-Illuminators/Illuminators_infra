resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-illuminators"
  lifecycle {
    prevent_destroy = true
  }
}
