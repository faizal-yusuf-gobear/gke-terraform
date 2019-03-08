terraform {
  required_version = ">= 0.11.0"
  backend "gcs" {
    bucket  = "terraform-state99"
    prefix  = "state/"
  }
}

#provider "vault" {
#  address = "${var.vault_addr}"
#}

#data "vault_generic_secret" "gcp_credentials" {
#  path = "secret/${var.vault_user}/gcp/credentials"
#}

#resource "vault_auth_backend" "k8s" {
#  type = "kubernetes"
#  path = "${var.vault_user}-gke-${var.environment}"
#  description = "Vault Auth backend for Kubernetes"
#}

provider "google" {
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}

resource "google_compute_address" "static-ip" {
  name = "static-ip-address"
}

resource "google_compute_instance" "default" {
  name         = "repository"
  machine_type = "${var.vm_machine_type}"
  zone         = "${var.gcp_zone}"

#  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "${var.node_os_image}"
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.static-ip.address}"
    }
  }
}

resource "google_container_cluster" "gkecluster" {
  name               = "${var.cluster_name}"
  description        = "example k8s cluster"
  zone               = "${var.gcp_zone}"
  initial_node_count = "${var.initial_node_count}"
  remove_default_node_pool = "true"
  #enable_kubernetes_alpha = "false"
  #enable_legacy_abac = "true"

  master_auth {
    username = "${var.master_username}"
    password = "${var.master_password}"
  }

  node_config {
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]
  }
}

resource "google_container_node_pool" "gkecluster_nodes" {
  name       = "${var.nodepool_name}"
  zone       = "${var.gcp_zone}"
  cluster    = "${google_container_cluster.gkecluster.name}"
  node_count = "${var.initial_node_count}"

  node_config {
    preemptible  = false
    machine_type = "${var.node_machine_type}"
    disk_size_gb = "${var.node_disk_size}"
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

# The following outputs allow authentication and connectivity to the GKE Cluster
# by using certificate-based authentication.
#output "client_certificate" {
#  value = "${google_container_cluster.gkecluster.master_auth.0.client_certificate}"
#}

#output "client_key" {
#  value = "${google_container_cluster.gkecluster.master_auth.0.client_key}"
#}

#output "cluster_ca_certificate" {
#  value = "${google_container_cluster.gkecluster.master_auth.0.cluster_ca_certificate}"
#}

#resource "null_resource" "auth_config" {
#  provisioner "local-exec" {
#    command = "curl --header \"X-Vault-Token: $VAULT_TOKEN\" --header \"Content-Type: application/json\" --request POST --data '{ \"kubernetes_host\": \"https://${google_container_cluster.k8sexample.endpoint}:443\", \"kubernetes_ca_cert\": \"${chomp(replace(base64decode(google_container_cluster.k8sexample.master_auth.0.cluster_ca_certificate), "\n", "\\n"))}\" }' ${var.vault_addr}/v1/auth/${vault_auth_backend.k8s.path}config"
#  }
#}

#resource "vault_generic_secret" "role" {
#  path = "auth/${vault_auth_backend.k8s.path}role/demo"
#  data_json = <<EOT
#  {
#    "bound_service_account_names": "cats-and-dogs",
#    "bound_service_account_namespaces": "default",
#    "policies": "${var.vault_user}",
#    "ttl": "24h"
#  }
#  EOT
#}

resource "google_sql_database_instance" "master" {
  name = "mysql-master"
  database_version = "MYSQL_5_6"
   #First-generation instance regions are not the conventional
   #Google Compute Engine regions. See argument reference below.
  region = "${var.gcp_region}"

  settings {
    tier = "db-f1-micro"
  }
}
