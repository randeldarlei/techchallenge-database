resource "aws_db_instance" "techchallenge-rds" {
  allocated_storage        = 20
  engine                   = "postgres"
  engine_version           = "16.1"
  identifier               = "techchallenge-rds"
  instance_class           = "db.t3.micro"
  storage_encrypted        = false
  publicly_accessible      = true
  delete_automated_backups = true
  skip_final_snapshot      = true
  db_name                  = "techchallenge"
  username                 = "master"
  password                 = "0dG3y771"
  apply_immediately        = true
  multi_az                 = false

  vpc_security_group_ids      = [data.terraform_remote_state.network.outputs.aws_security_group_id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}
