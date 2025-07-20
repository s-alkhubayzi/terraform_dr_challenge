resource "google_compute_network" "tfvpc" {
  name                    = "tf-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = var.project_id
}

