terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = var.http_port
  }
  volumes {
    host_path      = abspath("${path.module}/../../scripts/nginx.conf")
    container_path = "/etc/nginx/nginx.conf"
    read_only      = true
  }
}

