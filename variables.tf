variable "region" {
  default = "asia-southeast1"
}

variable "region_zone" {
  default = "asia-southeast1-a"
}

variable "credentials_file_path" {
  description = "Location of the credentials to use."
  default     = "~/home/devops/.google_creds/serviceaccount.json"
}