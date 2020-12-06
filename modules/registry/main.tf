provider "google" {
  project = var.project-name
  region  = var.region
}

provider "google-beta" {
  project = var.project-name
  region  = var.region
}

resource "google_container_registry" "gcr" {
    project = var.project-name
    location = "EU"
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_container_registry.gcr.id
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${var.cluster-service-account-email}"
}
