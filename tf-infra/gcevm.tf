resource "google_compute_instance" "poc_vm" {
  name         = var.instance_name
  machine_type = "n2d-standard-4"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 60
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name
    # 故意不配置 access_config 块，确保不分配公网 IP (Public IP)
  }

  scheduling {
    preemptible         = true
    provisioning_model  = "SPOT"
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }

  tags = ["poc-internal-vm"]
}
