resource "google_container_cluster" "gke-cluster" {
  name       = "gke-app-1"
  network    = "default"
  zone       = "asia-southeast1-a"
  remove_default_node_pool = true

  node_pool {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "gke-cluster" {
  name       = "gke-app-1"
  cluster    = "${google_container_cluster.primary.name}"
  zone       = "asia-southeast1-a"
  node_count = "1"

  node_config {
    machine_type = "n1-standard-1"
  }
  
  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }
  
  management {
    auto_repair  = true
    auto_upgrade = true
  }
}