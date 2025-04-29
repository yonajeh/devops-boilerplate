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

resource "null_resource" "create_templates_dir" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/templates"
  }
}

# Create the nginx.conf template file
resource "local_file" "nginx_template" {
  filename = "${path.module}/templates/nginx.conf.tftpl"
  content = templatefile("${path.module}/templates/nginx.conf.tftpl", {
    http_port      = var.http_port
    https_port     = var.https_port
    jenkins_host   = var.jenkins_host
    jenkins_port   = var.jenkins_port
    sonarqube_host = var.sonarqube_host
    sonarqube_port = var.sonarqube_port
    domain_name    = var.domain_name
  })

  depends_on = [null_resource.create_templates_dir]
}

# Render the final nginx configuration
resource "local_file" "nginx_config" {
  filename = "${path.module}/rendered.conf"
  content = templatefile("${path.module}/templates/nginx.conf.tftpl", {
    http_port      = var.http_port
    https_port     = var.https_port
    jenkins_host   = var.jenkins_host
    jenkins_port   = var.jenkins_port
    sonarqube_host = var.sonarqube_host
    sonarqube_port = var.sonarqube_port
    domain_name    = var.domain_name
  })

  depends_on = [local_file.nginx_template]
}

# Create and run the nginx container
resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id

  networks_advanced {
    name = var.docker_network_name
  }

  ports {
    internal = 80
    external = var.http_port
  }

  ports {
    internal = 443
    external = var.https_port
  }

  volumes {
    host_path      = abspath(local_file.nginx_config.filename)
    container_path = "/etc/nginx/nginx.conf"
    read_only      = true
  }

  depends_on = [
    local_file.nginx_config,
    docker_image.nginx
  ]
}
