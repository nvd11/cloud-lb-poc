output "instance_name" {
  description = "The name of the VM instance"
  value       = google_compute_instance.poc_vm.name
}

output "internal_ip" {
  description = "The internal IP address of the VM instance"
  value       = google_compute_instance.poc_vm.network_interface[0].network_ip
}
