provider "google" {
  project = var.project-name
  region  = var.region
}

provider "google-beta" {
  project = var.project-name
  region  = var.region
}

resource "google_cloudbuild_trigger" "trigger" {
  project = var.project-name
   
  
  trigger_template {
    branch_name = "master"
    repo_name   = var.repo_name
  }

  filename = "cloudbuild.yaml"   
}
