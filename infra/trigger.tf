resource "google_cloudbuild_trigger" "trigger" {
  name = "app-deploy"
  filename = "cloudbuild.yaml"
  description = "Trigger for building and deploying python-app"
  github {
    owner = "El-Zedy"
    name  = "test-cloud-build"
    push {
      branch = "test"
    }
  }
  #service_account = google_service_account.sa.id
}