# Create the password for cluster user access
resource "random_password" "cluster_user_password" {
  length           = 32
  special          = false
}

# Create a password for application user access
resource "random_password" "application_user_password" {
  length           = 32
  special          = false
}

