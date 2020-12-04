terraform {
   required_version  = ">= 0.12.18"
}

provider "google" {
  region              = var.region-name
  project             = var.project-name
}

provider "google-beta" {
  project = var.project-name
  region  = var.region-name
}
