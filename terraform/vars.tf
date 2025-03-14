variable "YC_KEYS" {
  type = object({
    folder_id          = string
    service_account_id = string
  })
  description = "ID облака YC и сервисного аккаунта"
}

variable "image_debian_id" {
  type        = string
  description = "debian 12"
  default     = "fd81u2jojucn3njlptqo"
}

variable "image_centos_id" {
  type        = string
  description = "centos stream 9"
  default     = "fd82urv9gfhghu9c5srf"
}

variable "MY_IP" {
  type = string
}
