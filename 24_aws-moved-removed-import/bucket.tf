resource "aws_s3_bucket" "teste" {
  bucket = "gasfgrv-bucket-moved-1"
}

resource "aws_s3_bucket" "bucket_2" {
  bucket = "gasfgrv-bucket-moved-2"
}

resource "aws_s3_bucket" "bucket_4" {
  bucket = "gasfgrv-bucket-moved-4"
}
