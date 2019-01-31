terraform {
  backend "gcs" {
    bucket  = "terraform-backend-1"
    credentials = "creds/gcs.json"
    prefix  = "terraform/state"
  }
}