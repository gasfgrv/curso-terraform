output "bucket_id" {
  description = "Id do Bucket criado na AWS"
  value       = aws_s3_bucket.bucket.id
}

output "bucket_arn" {
  description = "Id do Bucket criado na AWS"
  value       = aws_s3_bucket.bucket.arn
}
