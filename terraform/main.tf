resource "yandex_compute_instance" "srvr1" {
  name                      = "srvr1"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  zone        = "ru-central1-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_debian_id
      size     = 10
      #type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = [yandex_vpc_security_group.sg-srvr.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "debian:${file("~/.ssh/id_ed25519.pub")}"
  }
}

resource "yandex_compute_instance" "srvr2" {
  name                      = "srvr2"
  platform_id               = "standard-v3"
  allow_stopping_for_update = true
  zone        = "ru-central1-b"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.image_centos_id
      size     = 10
      #type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-2.id
    security_group_ids = [yandex_vpc_security_group.sg-srvr.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "debian:${file("~/.ssh/id_ed25519.pub")}"
  }
}