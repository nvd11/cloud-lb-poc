resource "google_compute_instance_group" "poc_unmig" {
  name        = "poc-unmanaged-instance-group"
  description = "Unmanaged Instance Group for Cloud LB PoC"
  zone        = var.zone
  network     = var.network_name

  instances = [
    google_compute_instance.poc_vm.id
  ]

  named_port {
    name = "http"
    port = "80"
  }
}
