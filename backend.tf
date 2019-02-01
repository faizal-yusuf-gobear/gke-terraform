terraform {
  backend "gcs" {
    bucket  = "gke-terraform-state"
    prefix  = "terraform/state"
  }
}