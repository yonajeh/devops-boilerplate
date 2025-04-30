# main.tf - Root Module
terraform {
  required_version = ">= 1.0.0"
}

# docker_install.tf
resource "null_resource" "install_docker" {
  triggers = {
    always_run = timestamp() # Ensures this runs every time
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Install Docker
      if ! command -v docker &> /dev/null; then
        echo "Installing Docker..."
        curl -fsSL https://get.docker.com | sh
        sudo usermod -aG docker $USER
      else
        echo "Docker already installed"
      fi

      # Start Docker service
      sudo systemctl enable --now docker
    EOT
  }
}


resource "docker_network" "app_network" {
  name   = "n22"
  driver = "bridge"

  # Prevent network recreation on every apply
  lifecycle {
    ignore_changes = [name]
  }
  depends_on = [null_resource.install_docker]

}

# Call Nginx Module
module "nginx" {
  source = "./modules/nginx"
  docker_network_name = docker_network.app_network.name

  domain_name    = var.domain_name
  http_port      = 80
  https_port     = 443
  jenkins_host   = "jenkins"
  keycloak_host   = "keycloak"
  keycloak_port   = 8082
  jenkins_port   = 8083
  sonarqube_host = "sonarqube"
  sonarqube_port = 9001
  sonarqube_ready_check = module.sonarqube.is_ready
  jenkins_ready_check   = module.jenkins.is_ready
  sonarqube_dependency  = module.sonarqube.container_id
  jenkins_dependency    = module.jenkins.container_id

  depends_on = [null_resource.install_docker]

}

# Call SonarQube Module
module "sonarqube" {
  source = "./modules/sonarqube"
  docker_network_name = docker_network.app_network.name

  sonarqube_port   = 9001
  postgres_user    = "sonar"
  postgres_password = "your_secure_password_here" # Change this!
  sonarqube_host   = "sonarqube"  # Must match what Nginx expects

  depends_on = [null_resource.install_docker]

}

# Call Jenkins Module
module "jenkins" {
  source = "./modules/jenkins"
  docker_network_name = docker_network.app_network.name

  # Authentication
  admin_user     = "admin"
  admin_password = var.jenkins_password  # Defined in variables.tf

  # Network
  jenkins_port     = 8083
  agent_port       = 50000
  docker_sock_path = "/var/run/docker.sock"  # For Docker-based builds
  depends_on = [null_resource.install_docker]

}

module "keycloak" {
  source = "./modules/keycloak"

  # Required variables
  admin_password = var.keycloak_admin_password

  # Optional variables (using defaults)
  # admin_user = "admin"
  hostname   = "auth.craftmanpro.online"

  depends_on = [null_resource.install_docker]

}


