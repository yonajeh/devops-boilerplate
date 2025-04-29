terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
# modules/nginx/main.tf
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.http_port  # ← Uses the variable
  }

  # Dynamic configuration for proxy rules
  volumes {
    host_path      = "${path.module}/nginx.conf"
    container_path = "/etc/nginx/nginx.conf"
  }

  # Only map HTTPS port if enabled
  dynamic "ports" {
    for_each = var.https_port != null ? [1] : []
    content {
      internal = 443
      external = var.https_port
    }
  }
}
