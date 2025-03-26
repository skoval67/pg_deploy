output "srvr1" {
  value = yandex_compute_instance.srvr1.network_interface.0.nat_ip_address
}

output "srvr2" {
  value = yandex_compute_instance.srvr2.network_interface.0.nat_ip_address
}
