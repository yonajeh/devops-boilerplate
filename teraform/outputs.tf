# outputs.tf - Corrected version
output "jenkins_access" {
  description = "Jenkins connection details"
  value = {
    direct_url       = "http://${var.domain_name}:${module.jenkins.jenkins_port}"
    proxied_url      = "http://${var.domain_name}/jenkins"
    admin_user       = module.jenkins.admin_user
    initial_password = module.jenkins.admin_password
    agent_port       = module.jenkins.agent_port
  }
  sensitive = true
}
