# Replace AWS EKS with GCP GKE cluster and IAM roles with service account

provider "google" {
  project = "your-gcp-project-id"
  region  = "us-central1"
}

# Create a GKE cluster
resource "google_container_cluster" "primary" {
  name     = "gke-cluster-cloud"
  location = "us-central1"

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"

  ip_allocation_policy {}
}

# Create a node pool for the cluster
resource "google_container_node_pool" "primary_nodes" {
  name       = "node-cloud"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location

  node_count = 1

  node_config {
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    labels = {
      env = "cloud"
    }
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 2
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }
}

# (Optional) Enable required GCP APIs
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}
