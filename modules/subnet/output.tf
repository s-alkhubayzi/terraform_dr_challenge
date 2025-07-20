output "subnet_id" {
  value = google_compute_subnetwork.subnet.id
}

output "subnet_cidr_range" {
  value = google_compute_subnetwork.subnet.ip_cidr_range
}

output "subnet_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}

output "subnet_name" {
  value = google_compute_subnetwork.subnet.name
}
