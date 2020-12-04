variable "project-name"{
  type    = string
  default = "rlt-test-297511"
}
variable "image" {
  type    = string
  default = "rlt-test"
}
variable "cluster-service-account-email" {
  type        = string
  default     = "rlt-test@rlt-test-297511.iam.gserviceaccount.com"  
}
variable "region" {
  type    = string
  default = "europe-west4"
}
