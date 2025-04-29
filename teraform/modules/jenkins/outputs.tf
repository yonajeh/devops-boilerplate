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

# modules/jenkins/outputs.tf
output "is_ready" {
  description = "Jenkins readiness check"
  value       = "curl -s http://localhost:${var.jenkins_port}/api/json | grep -q 'mode'"
}

output "container_id" {
  description = "Jenkins container ID"
  value       = docker_container.jenkins.id
}
