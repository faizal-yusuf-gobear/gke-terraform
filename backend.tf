terraform {
  backend "gcs" {
    bucket  = "terraform-backend-1"
    credentials = "creds/serviceaccount.json"
    prefix  = "terraform/state"
  }
}