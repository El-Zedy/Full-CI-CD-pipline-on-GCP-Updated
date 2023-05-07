# Bootstrapping Script to Install Apache
data "template_file" "statup_script" {
template = <<EOF
#!/bin/bash
sudo apt-get update;
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl";
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256";
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check;
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl;
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list;
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -;
sudo apt-get update && apt-get install google-cloud-cli;
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin;
export HOME=/home/$USER;
export KUBECONFIG=/home/$USER/.kube/config;
gcloud container clusters get-credentials privatecluster --zone us-central1-c --project moelzedy;
EOF
}
resource "google_compute_instance" "private_vm" {
  name         = var.vm_name
  machine_type = var.machine_type 
  zone         = var.zone
  tags         = ["private-vm"]

  boot_disk {
    initialize_params{
      image = var.vm_image
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnets[0].name
  }
  
  service_account {
    email  = google_service_account.sa[1].email
    scopes = ["cloud-platform"]
  }
  metadata_startup_script = data.template_file.statup_script.rendered

}
