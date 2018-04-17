provider "google" {
    version = "1.4.0"
    project = "${var.project}"
    region = "${var.region}"
}

resource "google_compute_address" "app_ip" {
    name = "reddit-app-ip"
}

resource "google_compute_instance" "app" {
    count = "${var.instance_count}"
    name = "reddit-app${count.index}"
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
        access_config {
            nat_ip = "${google_compute_address.app_ip.address}"
        }
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

resource "google_compute_firewall" "firewall_puma" {
    name = "allow-puma-default"
    # Название сети, в которой действует правило
    network = "default"
    # Какой доступ разрешить
    allow {
        protocol = "tcp"
        ports = ["9292"]
    }
    # Каким адресам разрешаем доступ
    source_ranges = ["0.0.0.0/0"]
    # Правило применимо для инстансов с тегом ...
    target_tags = ["reddit-app"]
}

<<<<<<< HEAD
=======
resource "google_compute_firewall" "firewall_ssh" {
    name = "default-allow-ssh"
    # Название сети, в которой действует правило
    network = "default"
    # Какой доступ разрешить
    allow {
        protocol = "tcp"
        ports = ["22"]
    }
    # Каким адресам разрешаем доступ
    source_ranges = ["0.0.0.0/0"]
}

#resource "google_compute_project_metadata_item" "default" {
#  key = "ssh-keys"
#  value = "appuser:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDPidPiD0QVEH/SPgcTwdaPVbxniLQznseoDh33tk7dOKF31cl4+nQ7tAo/XEkAPQg82qYT6O4RyMJxzAgBokCv0kp+w9g7kZG/Pb8+fTi8/hSczn0+rN93VG4/LIkth0DLzSkhIBCZge1G/SA52bUbg2BLE61IaItl1OgNhNbv+Pw0JHmkEtDBoRLljajnjJ/L18kxdgZihtDXA0FlN/ttuItNtlBOrPTMQaoteIyiTS9Yy8a4MBESjy3tvFCZqt0+F6DC0vVvCLHOn5dXAF1mQNpYBgutDICUO/gczp/gB5GSllZRxo0zf/bXrBuojDpRp0wOI4nf2uSdfaVT7aaL appuser"
#}

>>>>>>> HW 8 preparation
resource "google_compute_project_metadata_item" "default" {
  key = "ssh-keys"
  value = "${var.ssh_public_keys}"
}