resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "techchallenge_rds" {
  allocated_storage        = 20
  engine                   = "postgres"
  engine_version           = "16.1"
  instance_class           = "db.t3.micro"
  publicly_accessible      = true
  delete_automated_backups = true
  skip_final_snapshot      = true
  db_name                  = "techchallenge"
  username                 = "master"
  password                 = "0dG3y771"
  vpc_security_group_ids   = [data.terraform_remote_state.network.outputs.aws_security_group_id]
  db_subnet_group_name     = aws_db_subnet_group.rds_subnet_group.name
  apply_immediately        = true

  tags = {
    Name = "TechChallenge RDS"
  }
}
