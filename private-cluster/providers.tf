provider "google" {
  version = "~> 2.12.0"
  project = var.project-name
  region  = var.region-name
}

provider "google-beta" {
  version = "~> 2.12.0"
  project = var.project-name
  region  = var.region-name
}
