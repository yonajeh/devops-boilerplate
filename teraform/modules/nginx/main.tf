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

resource "local_file" "nginx_config" {
  filename = "${path.module}/rendered.conf"
  content  = templatefile("${path.module}/templates/nginx.conf.tftpl", {
    http_port      = var.http_port
    https_port     = var.https_port
    jenkins_host   = var.jenkins_host
    jenkins_port   = var.jenkins_port
    sonarqube_host = var.sonarqube_host
    sonarqube_port = var.sonarqube_port
    domain_name    = var.domain_name
  })
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
    host_path      = abspath("${path.module}/nginx.conf")  # Convert to absolute path
    container_path = "/etc/nginx/nginx.conf"
    read_only      = true
  }
  provisioner "local-exec" {
    command = "cp ${path.module}/nginx.conf ${abspath(path.module)}/nginx.conf.tmp"
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
