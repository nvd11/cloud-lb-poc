# 1. 预留区域级公网静态 IP
resource "google_compute_address" "l4_lb_ip" {
  name   = "poc-l4-lb-ip"
  region = var.region
}

# 2. TCP 健康检查 (针对 SSH 22 端口)
resource "google_compute_region_health_check" "l4_lb_hc" {
  name   = "poc-l4-lb-health-check"
  region = var.region

  tcp_health_check {
    port = "22"
  }
}

# 3. 区域级 Backend Service
resource "google_compute_region_backend_service" "l4_lb_backend" {
  name                  = "poc-l4-lb-backend-service"
  region                = var.region
  protocol              = "TCP"
  port_name             = "ssh"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_region_health_check.l4_lb_hc.id]

  backend {
    group = google_compute_instance_group.poc_unmig.id
  }
}

# 4. 区域级 Forwarding Rule (监听端口 22)
resource "google_compute_forwarding_rule" "l4_lb_forwarding_rule" {
  name                  = "poc-l4-lb-forwarding-rule"
  region                = var.region
  ip_address            = google_compute_address.l4_lb_ip.address
  ip_protocol           = "TCP"
  port_range            = "22"
  load_balancing_scheme = "EXTERNAL"
  backend_service       = google_compute_region_backend_service.l4_lb_backend.id
}

# 5. 防火墙规则：允许 SSH 及 GCP 健康检查流量访问目标 VM 22 端口
resource "google_compute_firewall" "allow_ssh_lb" {
  name    = "poc-allow-ssh-via-lb"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = [
    "0.0.0.0/0",
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]

  target_tags = ["poc-internal-vm"]
}
