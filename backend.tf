terraform {
  backend "gcs" {
    bucket  = "gke-terraform-backend"
    credentials = "creds/serviceaccount.json"
    prefix  = "terraform/state"
  }
}