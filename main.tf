provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_compute_instance" "web_server" {
  count         = var.instance_count
  name          = "web-server-${count.index}"
  machine_type  = var.machine_type
  zone          = element(var.zones, count.index % length(var.zones))
  tags          = ["web-server"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      # This allows external access
    }
  }

  metadata_startup_script = file("${path.module}/scripts/install_web.sh")
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

resource "google_compute_health_check" "default" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

resource "google_compute_instance_group" "web_group" {
  name        = "web-instance-group"
  zone        = var.zones[0]
  instances   = [for instance in google_compute_instance.web_server : instance.self_link]
  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_backend_service" "web_backend" {
  name                    = "web-backend-service"
  health_checks           = [google_compute_health_check.default.self_link]
  port_name               = "http"
  protocol                = "HTTP"
  timeout_sec             = 10
  connection_draining {
    draining_timeout_sec = 30
  }
  backend {
    group = google_compute_instance_group.web_group.self_link
  }
}

resource "google_compute_url_map" "web_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web_backend.self_link
}

resource "google_compute_target_http_proxy" "web_proxy" {
  name   = "web-proxy"
  url_map = google_compute_url_map.web_map.self_link
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name        = "http-forwarding-rule"
  target      = google_compute_target_http_proxy.web_proxy.self_link
  port_range  = "80"
  ip_protocol = "TCP"
}
