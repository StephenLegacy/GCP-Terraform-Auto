provider "google" {
  project = var.project_id
  region  = var.region
}

# Create a custom VPC network
resource "google_compute_network" "custom_vpc" {
  name                    = "custom-vpc"
  auto_create_subnetworks  = false
}

# Create a subnet in the custom VPC
resource "google_compute_subnetwork" "custom_subnet" {
  name          = "custom-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.custom_vpc.id
  region        = var.region
}

# Create a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.custom_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Create instances in the custom network
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
    subnetwork = google_compute_subnetwork.custom_subnet.id

    access_config {
      # This allows external access
    }
  }

  metadata_startup_script = file("${path.module}/scripts/install_web.sh")
}

# Health check for the instances
resource "google_compute_health_check" "default" {
  name = "http-health-check"

  http_health_check {
    port = 80
  }
}

# Instance group
resource "google_compute_instance_group" "web_group" {
  name        = "web-instance-group"
  zone        = var.zones[0]
  instances   = [for instance in google_compute_instance.web_server : instance.self_link]
  named_port {
    name = "http"
    port = 80
  }
}

# Backend service (Updated to remove `connection_draining`)
resource "google_compute_backend_service" "web_backend" {
  name              = "web-backend-service"
  health_checks     = [google_compute_health_check.default.self_link]
  port_name         = "http"
  protocol          = "HTTP"
  timeout_sec       = 10

  backend {
    group = google_compute_instance_group.web_group.self_link
  }
}

# URL map
resource "google_compute_url_map" "web_map" {
  name            = "web-url-map"
  default_service = google_compute_backend_service.web_backend.self_link
}

# HTTP proxy
resource "google_compute_target_http_proxy" "web_proxy" {
  name    = "web-proxy"
  url_map = google_compute_url_map.web_map.self_link
}

# Forwarding rule
resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name        = "http-forwarding-rule"
  target      = google_compute_target_http_proxy.web_proxy.self_link
  port_range  = "80"
  ip_protocol = "TCP"
}
