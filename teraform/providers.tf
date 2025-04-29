terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
    keycloak = {
      source  = "embracesbs/keycloak"
      version = "4.3.6"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}




