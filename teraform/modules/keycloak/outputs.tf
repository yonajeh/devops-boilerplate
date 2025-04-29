output "keycloak_url" {
  value = "http://${var.hostname}:8080"
}

output "admin_credentials" {
  value = {
    username = var.admin_user
    password = var.admin_password
  }
  sensitive = true
}
