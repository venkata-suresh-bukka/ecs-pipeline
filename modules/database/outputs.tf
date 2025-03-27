output "db_endpoint" {
  value = aws_db_instance.rds.endpoint
}
output "db_secret_arn" {
  value = aws_secretsmanager_secret.db_secret.arn
}

output "db_secret_version_arn" {
  value = aws_secretsmanager_secret_version.db_secret_version.arn
}
output "db_sg_id" {
  value = aws_security_group.db_sg.id
}
