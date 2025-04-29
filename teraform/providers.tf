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


provider "keycloak" {
  client_id = "admin-cli"
  username  = module.keycloak.admin_credentials.username
  password  = module.keycloak.admin_credentials.password
  url       = module.keycloak.keycloak_url
}

resource "keycloak_realm" "my_realm" {
  realm   = "appliiica"
  enabled = true
}
