resource "aws_db_instance" "techchallenge-rds" {
  allocated_storage        = 20
  engine                   = "postgres"
  engine_version           = "16.1"
  identifier               = "techchallenge-rds"
  instance_class           = "db.t3.micro"
  storage_encrypted        = false
  publicly_accessible      = false
  delete_automated_backups = true
  skip_final_snapshot      = true
  db_name                  = "techchallenge"
  username                 = "master"
  password                 = "0dG3y771"
  apply_immediately        = true
  multi_az                 = false

  # Referência ao Security Group do EKS que permite acesso ao RDS
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
}

# Subnet Group para o RDS nas subnets privadas
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.private_cluster_subnet_1.id,
    aws_subnet.private_cluster_subnet_2.id,
    aws_subnet.private_cluster_subnet_3.id
  ]

  tags = {
    Name = "rds-subnet-group"
  }
}
