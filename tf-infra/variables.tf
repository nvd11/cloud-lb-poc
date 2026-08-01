variable "project_id" {
  type        = string
  default     = "jason-hsbc"
  description = "GCP Project ID"
}

variable "region" {
  type        = string
  default     = "europe-west2"
  description = "GCP Region"
}

variable "zone" {
  type        = string
  default     = "europe-west2-c"
  description = "GCP Zone"
}

variable "network_name" {
  type        = string
  default     = "tf-vpc0"
  description = "VPC Network name"
}

variable "subnet_name" {
  type        = string
  default     = "tf-vpc0-subnet0"
  description = "Subnet name"
}

variable "instance_name" {
  type        = string
  default     = "poc-internal-vm"
  description = "VM Instance name"
}
