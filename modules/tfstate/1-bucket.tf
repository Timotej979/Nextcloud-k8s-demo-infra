# Creates an S3 bucket to store the Terraform state file
resource "aws_s3_bucket" "terraform_state" {
  bucket = "nextcloud-demo-tfstate"
     
  lifecycle {
    prevent_destroy = false # TODO: Set to true on production
  }

  tags = {
    Environment = var.environment
    Project     = var.project
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
    bucket = aws_s3_bucket.terraform_state.id

    versioning_configuration {
      status = "Enabled"
    }
}