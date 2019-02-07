resource "google_compute_network" "private_network" {
    name       = "private_network"
}

resource "google_compute_global_address" "private_ip_address" {
    name          = "private_ip_address"
    purpose       = "VPC_PEERING"
    address_type = "INTERNAL"
    prefix_length = 16
    network       = "${google_compute_network.private_network.self_link}"
}

resource "google_service_networking_connection" "private_vpc_connection" {
    network       = "${google_compute_network.private_network.self_link}"
    service       = "servicenetworking.googleapis.com"
    reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
}

resource "google_sql_database_instance" "instance" {
    depends_on = ["google_service_networking_connection.private_vpc_connection"]
    name = "private_instance"
    region = "asia-southeast1-a"
    settings {
        tier = "db-f1-micro"
        ip_configuration {
            ipv4_enabled = "false"
            private_network = "${google_compute_network.private_network.self_link}"
        }
    }
}
