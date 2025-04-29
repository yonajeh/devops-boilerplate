terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_container" "keycloak" {
  name  = "keycloak"
  image = "quay.io/keycloak/keycloak:latest"
  ports {
    internal = 8080
    external = 8082
  }
  env = [
    "KEYCLOAK_ADMIN=yonajeh",
    "KEYCLOAK_ADMIN_PASSWORD=yonaj@eh",
    "KC_PROXY=edge",
    "KC_HOSTNAME=keycloak.craftmanpro.online"
  ]
  command = ["start-dev"]
}
