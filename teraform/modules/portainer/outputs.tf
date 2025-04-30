output "portainer_access" {
  value = {
    url      = "http://${var.hostname}"
  }
}
