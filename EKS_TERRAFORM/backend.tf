terraform {
  backend "gcs" {
    bucket  = "demo-v1"              # Replace with your actual GCS bucket name
    prefix  = "EKS/terraform.tfstate"  # Path inside the bucket to store the state file
  }
}
