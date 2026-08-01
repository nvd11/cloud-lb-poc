# 1. 预留全局静态公网 IP (7层 HTTP LB 专享)
resource "google_compute_global_address" "l7_lb_ip" {
  name = "poc-l7-lb-ip"
}

# 2. HTTP 健康检查 (针对 Nginx 80 端口 GET / 路径)
resource "google_compute_health_check" "l7_lb_hc" {
  name = "poc-l7-lb-health-check"

  http_health_check {
    port         = 80
    request_path = "/"
  }
}

# 3. 全局 Backend Service (关联 UnMIG 实例组的 named_port "http")
resource "google_compute_backend_service" "l7_lb_backend" {
  name                  = "poc-l7-lb-backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  health_checks         = [google_compute_health_check.l7_lb_hc.id]

  backend {
    group          = google_compute_instance_group.poc_unmig.id
    balancing_mode = "CONNECTION"
  }
}

# 4. URL Map 路由表 (默认路由指向 l7_lb_backend)
resource "google_compute_url_map" "l7_lb_url_map" {
  name            = "poc-l7-lb-url-map"
  default_service = google_compute_backend_service.l7_lb_backend.id
}

# 5. Target HTTP Proxy (目标 HTTP 代理解包器)
resource "google_compute_target_http_proxy" "l7_lb_proxy" {
  name    = "poc-l7-lb-proxy"
  url_map = google_compute_url_map.l7_lb_url_map.id
}

# 6. 全局 Forwarding Rule (LB 入口：监听公网 80 端口)
resource "google_compute_global_forwarding_rule" "l7_lb_forwarding_rule" {
  name                  = "poc-l7-lb-forwarding-rule"
  ip_address            = google_compute_global_address.l7_lb_ip.address
  ip_protocol           = "TCP"
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  target                = google_compute_target_http_proxy.l7_lb_proxy.id
}

# 7. 防火墙规则：允许 GCP 7层健康检查及代理网段访问 VM 80 端口
resource "google_compute_firewall" "allow_http_lb" {
  name    = "poc-allow-http-via-lb"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  # GCP 官方 Health Check 与 Envoy 代理标准网段
  source_ranges = [
    "0.0.0.0/0",
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]

  target_tags = ["poc-internal-vm"]
}
