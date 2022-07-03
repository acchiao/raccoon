variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type    = string
  default = "primary"
}

variable "pool_name" {
  type    = string
  default = "primary"
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.22.8-gke.202"
}

variable "machine_type" {
  type    = string
  default = "e2-medium"
}

variable "master_authorized_network_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
