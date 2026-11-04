resource "aws_s3_bucket" "teste" {
  bucket = "gasfgrv-bucket-moved-1"
}

resource "aws_s3_bucket" "bucket_2" {
  bucket = "gasfgrv-bucket-moved-2"
}

resource "aws_s3_bucket" "bucket_3" {
  bucket = "gasfgrv-bucket-moved-3"
}

moved {
  from = aws_s3_bucket.bucket_1
  to   = aws_s3_bucket.teste
}
