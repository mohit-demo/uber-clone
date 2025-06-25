terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# Configure the GCP Provider
provider "google" {
  project = "your-gcp-project-id"   # <-- Replace this with your actual GCP project ID
  region  = "us-central1"           # <-- You can change to your preferred GCP region
}
