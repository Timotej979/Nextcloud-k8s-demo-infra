variable "environment" {
  description = <<EOT
  The environment for the infrastructure. 
  Different environments have different deletion protection settings:

  - "prod": Production environment with deletion protection enabled (delete_protection = true).
  - "stage" or others: Staging or other environments with deletion protection disabled (delete_protection = false).
  EOT
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}