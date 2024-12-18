output "rds_endpoint" {
  description = "Endpoint do RDS"
  value       = aws_db_instance.techchallenge-rds.endpoint
}
