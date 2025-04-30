terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}


resource "docker_container" "portainer" {
  name  = "portainer"
  image    = "portainer/portainer-ce:lts"  # Direct image string
  restart = "unless-stopped"


  networks_advanced {
    name = var.docker_network_name
  }

  ports {
    internal = 9000
    external = 9000
  }

  ports {
    internal = 8000
    external = 8000
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }

  volumes {
    host_path      = "/opt/portainer_data"
    container_path = "/data"
  }

  command = [
    "--admin-password='${var.docker_network_name}'",
    "--admin-email='${var.admin_user}'",
    "--admin-name='${var.admin_user_email}'"
  ]
}
