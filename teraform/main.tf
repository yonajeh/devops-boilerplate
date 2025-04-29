# main.tf - Root Module
terraform {
  required_version = ">= 1.0.0"
}

resource "docker_network" "app_network" {
  name   = "n22"
  driver = "bridge"
}

# Call Nginx Module
module "nginx" {
  source = "./modules/nginx"

  domain_name    = var.domain_name
  http_port      = 80
  https_port     = 443
  jenkins_host   = "jenkins"
  jenkins_port   = 8080
  sonarqube_host = "sonarqube"
  sonarqube_port = 9001
}

# Call SonarQube Module
module "sonarqube" {
  source = "./modules/sonarqube"

  sonarqube_port   = 9001
  postgres_user    = "sonar"
  postgres_password = "your_secure_password_here" # Change this!
  sonarqube_host   = "sonarqube"  # Must match what Nginx expects
}

# Call Jenkins Module
module "jenkins" {
  source = "./modules/jenkins"

  # Authentication
  admin_user     = "admin"
  admin_password = var.jenkins_password  # Defined in variables.tf

  # Network
  jenkins_port     = 8080
  agent_port       = 50000
  docker_sock_path = "/var/run/docker.sock"  # For Docker-based builds
}

# Define dependencies between services
resource "null_resource" "service_ordering" {
  depends_on = [
    module.sonarqube,  # SonarQube should be ready before Jenkins
    module.nginx
  ]
}
