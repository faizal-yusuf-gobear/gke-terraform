resource "google_storage_bucket" "gke-tf-state" {
  name     = "gke-terraform-state"
  location = "asia-southeast1-a"
}

resource "google_storage_bucket_acl" "state-store-acl" {
  bucket = "${google_storage_bucket.gke-tf-state.name}"
  predefined_acl = "authenticatedRead"
}