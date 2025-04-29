# main.tf - Root Module
terraform {
  required_version = ">= 1.0.0"
}

# Call Nginx Module
module "nginx" {
  source = "./modules/nginx"

  # Customize Nginx ports if needed
  http_port  = 80
  https_port = 443  # For future SSL implementation

  # Link to other services
  jenkins_host = "jenkins"  # Docker internal DNS
  sonarqube_host = "sonarqube"
}

# Call SonarQube Module
module "sonarqube" {
  source = "./modules/sonarqube"

  # PostgreSQL credentials
  postgres_user     = "sonar"
  postgres_password = "sonar_password"  # In production, use secrets/vault

  # Port configuration
  sonarqube_port = 9000
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
