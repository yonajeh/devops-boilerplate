# modules/jenkins/outputs.tf
output "jenkins_port" {
  description = "Jenkins web interface port"
  value       = var.jenkins_port
}

output "agent_port" {
  description = "Jenkins agent communication port"
  value       = var.agent_port
}

output "admin_user" {
  description = "Jenkins admin username"
  value       = var.admin_user
}

output "admin_password" {
  description = "Jenkins admin password"
  value       = var.admin_password
  sensitive   = true
}
