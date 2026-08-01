output "instance_name" {
  description = "The name of the VM instance"
  value       = google_compute_instance.poc_vm.name
}

output "internal_ip" {
  description = "The internal IP address of the VM instance"
  value       = google_compute_instance.poc_vm.network_interface[0].network_ip
}

output "unmig_name" {
  description = "The name of the Unmanaged Instance Group"
  value       = google_compute_instance_group.poc_unmig.name
}

output "unmig_self_link" {
  description = "The self_link of the Unmanaged Instance Group"
  value       = google_compute_instance_group.poc_unmig.self_link
}
