output "is_ready" {
  description = "SonarQube readiness check"
  value       = "curl -s http://localhost:${var.sonarqube_port}/api/system/status | grep -q 'UP'"
}

output "container_id" {
  description = "SonarQube container ID"
  value       = docker_container.sonarqube.id
}
