# Full-CI-CD-pipline-on-GCP-Updated
Updated version of this repo: https://github.com/El-Zedy/Full-CI-CD-pipline-on-GCP by using Terraform for the project infrastructure instead of console and make the GKE cluster private instead of public.

- Use Terraform to deploy all the project infrastructure.
- Use GCP private pool and peered it with private GKE cluster vpc to allow cloud build to access the cluster and perform cloudbuild.yml steps..
