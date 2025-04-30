output "portainer_access" {
  value = {
    url      = "http://${var.hostname}"
    username = var.admin_user
    email    = var.admin_user_email
  }
  sensitive = true
}
