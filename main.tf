module "gke" {
  source = "./modules/gke"
  project = var.project_name
  region  = var.region
}
module "cicd" {
  source = "./modules/cicd"
}

module "registry"{
  source="./modules/registry"
}
