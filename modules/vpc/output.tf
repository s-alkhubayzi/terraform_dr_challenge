output "vpc_id" {
  value = google_compute_network.tfvpc.id
}

output "self_link" {
  value = google_compute_network.tfvpc.self_link
}