provider "google" {
  credentials = "${file("./creds/serviceaccount.json")}"
  project     = "my-gke-project"
  region      = "asia-southeast1-a"
}