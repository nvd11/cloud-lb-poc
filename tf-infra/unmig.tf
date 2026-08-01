resource "google_compute_instance_group" "poc_unmig" {
  name        = "poc-unmanaged-instance-group"
  description = "Unmanaged Instance Group for Cloud LB PoC"
  zone        = var.zone
  network     = google_compute_instance.poc_vm.network_interface[0].network

  instances = [
    google_compute_instance.poc_vm.id
  ]

  named_port {
    name = "ssh"
    port = "22"
  }
}

resource "google_compute_instance_group" "poc_unmig_l7" {
  name        = "poc-unmanaged-instance-group-l7"
  description = "Unmanaged Instance Group for L7 ALB PoC"
  zone        = var.zone
  network     = google_compute_instance.poc_vm.network_interface[0].network

  instances = [
    google_compute_instance.poc_vm.id
  ]

  named_port {
    name = "http"
    port = "80"
  }
}
