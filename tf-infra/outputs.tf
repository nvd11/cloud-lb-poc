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

output "l4_lb_public_ip" {
  description = "The public IP address of the L4 Load Balancer"
  value       = google_compute_address.l4_lb_ip.address
}

output "ssh_command_via_lb" {
  description = "Command to SSH into internal VM via L4 Load Balancer"
  value       = "ssh gateman@${google_compute_address.l4_lb_ip.address}"
}

output "l7_lb_public_ip" {
  description = "The public IP address of the L7 Load Balancer"
  value       = google_compute_global_address.l7_lb_ip.address
}

output "curl_command_via_l7_lb" {
  description = "Command to test HTTP access via L7 Load Balancer"
  value       = "curl -i http://${google_compute_global_address.l7_lb_ip.address}/"
}
