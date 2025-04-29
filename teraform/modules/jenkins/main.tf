terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
# modules/jenkins/main.tf
resource "docker_volume" "jenkins_data" {
  name = "jenkins_data"
}

resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts-jdk17"
}

resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.jenkins.image_id

  networks_advanced {
    name = var.docker_network_name
  }

  ports {
    internal = 8080
    external = var.jenkins_port  # Use variable
  }

  ports {
    internal = 50000
    external = var.agent_port    # Use variable
  }
  volumes {
    host_path      = var.docker_sock_path  # Use variable
    container_path = "/var/run/docker.sock"
  }
  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }
  env = [
    "JAVA_OPTS=-Djenkins.install.runSetupWizard=false",
    "JENKINS_ADMIN_ID=${var.admin_user}",
    "JENKINS_ADMIN_PASSWORD=${var.admin_password}"
  ]
}
