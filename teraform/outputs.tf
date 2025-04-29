# outputs.tf - Complete Service Outputs

# Nginx Access Points
output "nginx_endpoints" {
  description = "Nginx access URLs"
  value = {
    http_entrypoint    = "http://${var.domain_name}:${module.nginx.http_port}"
    jenkins_proxy_url = "http://${var.domain_name}:${module.nginx.http_port}/jenkins"
    sonarqube_proxy_url = "http://${var.domain_name}:${module.nginx.http_port}/sonarqube"
    config_file_path  = abspath(local_file.nginx_config.filename)
  }
}

# Jenkins Access Information
output "jenkins_access" {
  description = "Jenkins connection details"
  value = {
    direct_url       = "http://${var.domain_name}:${module.jenkins.jenkins_port}"
    proxied_url      = "http://${var.domain_name}/jenkins"
    admin_user      = module.jenkins.admin_user
    initial_password = module.jenkins.admin_password
    agent_port      = module.jenkins.jenkins_port
  }
  sensitive = true
}

# SonarQube Access Information
output "sonarqube_access" {
  description = "SonarQube connection details"
  value = {
    direct_url       = "http://${var.domain_name}:${module.sonarqube.sonarqube_port}"
    proxied_url      = "http://${var.domain_name}/sonarqube"
    admin_username   = "admin"
    admin_password   = "admin" # Default, change after first login
    postgres_user    = module.sonarqube.postgres_user
  }
  sensitive = true
}

# Docker Services Summary
output "service_ports" {
  description = "All exposed service ports"
  value = {
    nginx      = module.nginx.http_port
    jenkins    = module.jenkins.jenkins_port
    sonarqube  = module.sonarqube.sonarqube_port
    jenkins_agent = module.jenkins.agent_port
  }
}

# Post-Deployment Notes
output "access_instructions" {
  description = "Important access information"
  value = <<EOT

  === SERVICE ACCESS POINTS ===
  Jenkins:
  - Direct: http://${var.domain_name}:${module.jenkins.jenkins_port}
  - Proxied: http://${var.domain_name}/jenkins
  - Initial admin: ${module.jenkins.admin_user} / ${module.jenkins.admin_password}

  SonarQube:
  - Direct: http://${var.domain_name}:${module.sonarqube.sonarqube_port}
  - Proxied: http://${var.domain_name}/sonarqube
  - Default admin: admin / admin

  === NEXT STEPS ===
  1. Change default SonarQube credentials
  2. Configure Jenkins plugins
  3. Check Nginx config at: ${abspath(local_file.nginx_config.filename)}
  EOT
}
