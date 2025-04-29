terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
resource "docker_volume" "jenkins_data" {
  name = "jenkins_data"
}

resource "docker_image" "jenkins" {
  name = "jenkins/jenkins:lts-jdk17"
}

resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.jenkins.image_id
  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 50000
    external = 50000  # Agent communication port
  }
  volumes {
    volume_name    = docker_volume.jenkins_data.name
    container_path = "/var/jenkins_home"
  }
  env = [
    "JAVA_OPTS=-Djenkins.install.runSetupWizard=false"
  ]
  # Upload initial config (Groovy scripts)
  provisioner "file" {
    source      = "${path.module}/jenkins-config/"
    destination = "/var/jenkins_home/init.groovy.d/"
  }
}
