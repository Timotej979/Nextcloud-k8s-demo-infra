# Create a DynamoDB table to store Terraform state lock.
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "nextcloud-demo-tfstate-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}
