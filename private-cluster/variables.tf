variable "project-name" {
    type     = string
    default  = "rlt-test-297511" 
}

variable "region-name" {
    type     = string
    default  = "europe-west4"
}

variable "vpc-name" {
    type     = string
    default  = "cluster-vpc"
}

variable "svc-net" {
    type     = string
    default  = "services-range"
}

variable "pod-net" {
    type     = string
    default  = "pods-range"
}

variable "subnetwork-name" {
    type      = string
    default   = "private-subnet"
}

variable "pool" {
    type      = string
    default   = "cluster-nodes"
}

variable "cluster-name" {
    type      = string
    default   = "gke-cluster-new"
}

