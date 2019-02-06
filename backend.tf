terraform {
  backend "gcs" {
    bucket  = "gke-terraform-state1"
    prefix  = "terraform/state"
  }
}