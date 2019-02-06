resource "google_container_cluster" "gke-cluster" {
  name       = "gke-app-1"
  network    = "default"
  zone       = "asia-southeast1-a"
  initial_node_count = 1
}