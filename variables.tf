variable "gcp_region" {
  default = "asia-southeast1"
}

variable "gcp_zone" {
  default = "asia-southeast1-a"
}

variable "gcp_project" {
  description = "GCP project name"
  default = "my-k8-app"
}

variable "cluster_name" {
  description = "Name of the K8s cluster"
  default = "k8-cluster"
}

variable "nodepool_name" {
	description = "name of nodepool"
	default = "k8-nodepool"
}

variable "initial_node_count" {
  description = "Number of worker VMs to initially create"
  default = 1
}

variable "master_username" {
  description = "Username for accessing the Kubernetes master endpoint"
  default = ""
}

variable "master_password" {
  description = "Password for accessing the Kubernetes master endpoint"
  default = ""
}

variable "node_machine_type" {
  description = "GCE machine type"
  default = "n1-standard-1"
}

variable "node_disk_size" {
  description = "Node disk size in GB"
  default = "10"
}

#variable "environment" {
#  description = "value passed to ACS Environment tag"
#  default = "dev"
#}

#variable "vault_user" {
#  description = "Vault userid: determines location of secrets and affects path of k8s auth backend"
#}

#variable "vault_addr" {
#  description = "Address of Vault server including port"
#}

#variable "org_id" {
#  description = "The ID of the Google Cloud Organization."
#}

#variable "billing_account_id" {
#  description = "The ID of the associated billing account (optional)."
#}

#variable "credentials_file_path" {
#  description = "Location of the credentials to use."
#  default     = "/home/teamcity/.gcloud_creds/terraform/serviceaccount.json"
#}