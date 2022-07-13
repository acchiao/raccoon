variable "project" {
  type = string
}

variable "project_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "release" {
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

variable "master_authorized_network_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "node_count" {
  type    = number
  default = 1
}

variable "node_machine_type" {
  type    = string
  default = "e2-medium"
}

variable "node_preemptible" {
  type    = bool
  default = true
}

variable "node_image_type" {
  type    = string
  default = "COS_CONTAINERD"
}

variable "node_disk_size_gb" {
  type    = number
  default = 50
}
