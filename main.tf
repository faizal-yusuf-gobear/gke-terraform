provider "google" {
  project     = "gke-app-230805"
  region      = "${var.region}"
  credentials = "${file("${var.credentials_file_path}")}"
}

resource "google_container_cluster" "gke-cluster" {
  name       = "gke-app-1"
  network    = "default"
  zone       = "${var.region_zone}"
  remove_default_node_pool = true

  node_pool {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "gke-cluster" {
  name       = "gke-app-1"
  cluster    = "${google_container_cluster.primary.name}"
  zone       = "${var.region_zone}"
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

resource "google_sql_database_instance" "master" {
  name = "master-instance"
  database_version = "MYSQL_5_6"
  # First-generation instance regions are not the conventional
  # Google Compute Engine regions. See argument reference below.
  region = "${var.region}"

  settings {
    tier = "D0"
  }
}

resource "google_compute_global_address" "default" {
  name = "webapp-static-ip"
}