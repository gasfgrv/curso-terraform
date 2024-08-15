resource "aws_s3_bucket" "bucket" {
  bucket = "gasfgrv-terraform-remote-state"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
