terraform {
  backend "gcs" {
    bucket  = "gke-terraform-backend"
    prefix  = "terraform/state"
  }
}