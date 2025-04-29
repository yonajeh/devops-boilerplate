variable "admin_user" {
  description = "Keycloak admin username"
  type        = string
  default     = "yonajeh"
}

variable "admin_password" {
  description = "Keycloak admin password"
  type        = string
  sensitive   = true
}

variable "hostname" {
  description = "Keycloak hostname"
  type        = string
  default     = "keycloak.craftmanpro.online"
}

