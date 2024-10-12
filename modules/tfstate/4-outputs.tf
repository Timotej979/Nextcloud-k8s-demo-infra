output "bucket_name" {
  description = "The name of the S3 bucket"
  value = module.aws_s3_bucket.s3_bucket_name
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value = module.aws_s3_bucket.s3_bucket_arn
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table"
  value       =  aws_dynamodb_table.this.name
}