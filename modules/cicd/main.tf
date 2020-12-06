resource "google_sourcerepo_repository" "repo" {
  project = var.project-name
  name    = var.repo-name
}

resource "google_cloudbuild_trigger" "trigger" {
  project = var.project-name
  name    = var.trigger-name
   
  
  trigger_template {
    branch_name = "master"
    repo_name   = google_sourcerepo_repository.repo.name
  }

  filename = "cloudbuild.yaml"   
}

data "google_project" "project" {}

resource "google_project_iam_member" "cloudbuild_roles" {
    depends_on  = [google_cloudbuild_trigger.trigger]
    for_each    = toset(["roles/container.developer","roles/iam.serviceAccountUser"])

    project     = var.project-name
    role        = each.key
    member      = "serviceAccount:${data.google_project.project.number}@cloudbuild.gserviceaccount.com"
}
