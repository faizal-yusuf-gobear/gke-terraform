resource "google_storage_bucket" "gke-tf-state" {
  name     = "gke-terraform-state"
  location = "asia-southeast1-a"
}

resource "google_storage_bucket_acl" "tf-store-acl" {
  bucket = "${google_storage_bucket.gke-tf-state.name}"

  role_entity = [
    "OWNER:user-my.email@gmail.com",
    "READER:group-mygroup",
  ]
}
