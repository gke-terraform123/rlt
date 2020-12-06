provider "google" {
  project = var.project-name
  region  = var.region
}

provider "google-beta" {
  project = var.project-name
  region  = var.region
}
