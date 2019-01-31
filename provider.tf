provider "google" {
  credentials = "${file("./creds/serviceaccount.json")}"
  project     = "faizal-gke-cluster"
  region      = "asia-southeast1-a"
}
