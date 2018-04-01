resource "google_compute_instance" "app2" {
    name = "reddit-app2"
    machine_type = "g1-small"
    zone = "${var.zone}"

    tags = ["reddit-app"]

    metadata {
        ssh-keys = "appuser:${file(var.public_key_path)}"
    }

    # определение загрузочного диска
    boot_disk {
        initialize_params {
            image = "${var.disk_image}"
        }
    }
    # определение сетевого интерфейса
    network_interface {
        # сеть, к которой присоединить данный интерфейс
        network = "default"
        # использовать ephemeral IP для доступа из Интернет
        access_config {}
    }

    connection {
    type = "ssh"
    user = "appuser"
    agent = false
    private_key = "${file(var.private_key_path)}"
    }

    provisioner "file" {
        source = "files/puma.service"
        destination = "/tmp/puma.service"
    }

    provisioner "remote-exec" {
        script = "files/deploy.sh"
    }
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "default-rule"
  target     = "${google_compute_target_http_proxy.default.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name        = "test-proxy"
  description = "a description"
  url_map     = "${google_compute_url_map.default.self_link}"
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  description     = "a description"
  default_service = "${google_compute_backend_service.default.self_link}"
}

resource "google_compute_backend_service" "default" {
  name        = "default-backend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
      group = "${google_compute_instance_group.reddit-app-group.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.default.self_link}"]
}

resource "google_compute_instance_group" "reddit-app-group" {
  name        = "reddit-app-group"
  description = "Reddit app instance group"

  instances = [
    "${google_compute_instance.app.self_link}",
    "${google_compute_instance.app2.self_link}",
  ]

  named_port {
    name = "http"
    port = "9292"
  }

  zone = "europe-west1-b"
}

resource "google_compute_http_health_check" "default" {
  name               = "test"
  request_path       = "/"
  check_interval_sec = 5
  timeout_sec        = 5
  port               = 9292
}