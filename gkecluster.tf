resource "google_container_cluster" "gke-cluster" {
  name       = "my-gke-cluster"
  network    = "default"
  zone       = "asia-southeast1-a"
  initial_node_count = 1
}
