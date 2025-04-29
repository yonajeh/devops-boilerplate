terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}
resource "docker_network" "sonarnet" {
  name = "sonarnet"
}

resource "docker_volume" "sonarqube_data" {
  name = "sonarqube_data"
}

resource "docker_volume" "postgres_data" {
  name = "postgres_data"
}

# PostgreSQL for SonarQube
resource "docker_image" "postgres" {
  name = "postgres:13"
}

resource "docker_container" "postgres" {
  name  = "sonarqube_db"
  image = docker_image.postgres.image_id
  env = [
    "POSTGRES_USER=sonar",
    "POSTGRES_PASSWORD=sonar"
  ]
  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
  networks_advanced {
    name = docker_network.sonarnet.name
  }
}

# SonarQube
resource "docker_image" "sonarqube" {
  name = "sonarqube:lts"
}

resource "docker_container" "sonarqube" {
  name  = "sonarqube"
  image = docker_image.sonarqube.image_id
  env = [
    "SONAR_JDBC_URL=jdbc:postgresql://sonarqube_db:5432/sonar",
    "SONAR_JDBC_USERNAME=sonar",
    "SONAR_JDBC_PASSWORD=sonar"
  ]
  ports {
    internal = 9000
    external = 9000
  }
  volumes {
    volume_name    = docker_volume.sonarqube_data.name
    container_path = "/opt/sonarqube/data"
  }
  networks_advanced {
    name = docker_network.sonarnet.name
  }
  depends_on = [docker_container.postgres]
}
