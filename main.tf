module "gke" {
  source = "./modules/gke"
}
module "cicd" {
  source = "./modules/cicd"
}

module "registry"{
  source="./modules/registry"
}
