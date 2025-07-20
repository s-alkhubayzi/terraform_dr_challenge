resource "google_compute_subnetwork" "subnet" {
  name                     = var.subnet_name
  network                  = var.vpc_id
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  project                  = var.project_id
  private_ip_google_access = true
}
