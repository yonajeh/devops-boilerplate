# outputs.tf - Display critical information after deployment

output "nginx_access_urls" {
  description = "Nginx access endpoints"
  value = {
    http_url          = "http://${var.domain_name}:${module.nginx.http_port}"
    jenkins_proxy_url = "http://${var.domain_name}:${module.nginx.http_port}/jenkins"
    # https_url will be available after SSL configuration
  }
}

output "sonarqube_access" {
  description = "SonarQube connection details"
  value = {
    url       = "http://${var.domain_name}:${module.sonarqube.sonarqube_port}"
    admin_pwd = "admin" # Default credentials (change after first login)
  }
  sensitive = true
}

output "jenkins_access" {
  description = "Jenkins connection details"
  value = {
    url         = "http://${var.domain_name}:${module.jenkins.jenkins_port}"
    admin_user  = module.jenkins.admin_user
    initial_pwd = module.jenkins.admin_password
  }
  sensitive = true
}

output "docker_services_summary" {
  description = "List of all running Docker services"
  value = [
    "nginx:${module.nginx.http_port}",
    "sonarqube:${module.sonarqube.sonarqube_port}",
    "jenkins:${module.jenkins.jenkins_port}"
  ]
}

output "important_notes" {
  description = "Post-deployment instructions"
  value = <<EOT

  IMPORTANT NEXT STEPS:
  1. Jenkins setup:
     - Access: ${module.jenkins.admin_user} / ${module.jenkins.admin_password}
     - Install suggested plugins on first run
  2. SonarQube:
     - Change default admin password immediately
  3. Nginx:
     - Configure SSL certificates for production use

  Access services:
  - Jenkins:    http://${var.domain_name}:${module.jenkins.jenkins_port}
  - SonarQube:  http://${var.domain_name}:${module.sonarqube.sonarqube_port}
  EOT
}
