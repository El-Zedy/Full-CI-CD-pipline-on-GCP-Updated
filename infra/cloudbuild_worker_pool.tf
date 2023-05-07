resource "google_cloudbuild_worker_pool" "project-pool" {
  name = "project-pool"
  location = "us-central1-c"
  worker_config {
    disk_size_gb = 100
    machine_type = "e2-standard-4"
    no_external_ip = false
  }
   network_config {
    peered_network = google_compute_network.vpc_network.id
  }
}
