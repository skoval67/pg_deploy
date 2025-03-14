output "bastion" {
  value = yandex_compute_instance.srvr1.network_interface.0.nat_ip_address
}
