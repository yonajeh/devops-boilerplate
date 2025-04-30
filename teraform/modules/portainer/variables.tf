variable "admin_user" {
  description = "portainer admin username"
  type        = string
  default     = "yonajeh"
}

variable "admin_user_email" {
  description = "portainer admin email"
  type        = string
  default     = "yo.najeh@gmail.com"
}

variable "admin_password" {
  description = "Keycloak admin password"
  type        = string
  sensitive   = true
}

variable "hostname" {
  description = "portainer hostname"
  type        = string
  default     = "portainer.craftmanpro.online"
}

variable "docker_network_name" {
  type    = string
  default = "n22"
}
