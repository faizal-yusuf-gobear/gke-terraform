resource "google_container_node_pool" "extra-pool" {
  name	= "extra-node-pool"
  zone  = "asia-southeast1-a"
  cluster = "${google_container_cluster.gke-cluster.name}"
  initial_node_count = 2 
}
