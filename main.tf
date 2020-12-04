module "gke" {
  source = "./modules/gke"
  project = var.project-name
  region  = var.region
}
module "cicd" {
  source = "./modules/cicd"
}

module "registry"{
  source="./modules/registry"
}
