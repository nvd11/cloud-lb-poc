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

  metadata_startup_script = <<-EOF
    #!/bin/bash
    export DEBIAN_FRONTEND=noninteractive
    dpkg --configure -a || true
    apt-get update
    apt-get install -y nginx
    echo "<h1>Hello from GCP L7 LB Backend - $(hostname)</h1>" > /var/www/html/index.html
    systemctl restart nginx

    # 自动恢复中断的 dpkg，补齐 SSH Host Keys，重置 systemd 频率限制并启动 ssh
    ssh-keygen -A || true
    systemctl reset-failed ssh || true
    systemctl restart ssh
  EOF
}
