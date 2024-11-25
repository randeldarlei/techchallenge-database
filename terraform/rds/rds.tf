resource "aws_rds_cluster" "postgresql" {
  cluster_identifier          = "techchallenge"
  engine                      = "aurora-postgresql"
  database_name               = "techchallenge"
  master_username             = "master"
  master_password             = "0dG3y771"
  skip_final_snapshot         = true
  deletion_protection         = false
  vpc_security_group_ids      = [data.terraform_remote_state.network.outputs.aws_security_group_id]

  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  tags = {
    Name = "techchallenge-cluster"
  }
}

resource "aws_rds_cluster_instance" "postgresql_instance" {
  identifier              = "techchallenge-instance"
  instance_class          = "db.t4g.medium"
  cluster_identifier      = aws_rds_cluster.postgresql.id
  engine                  = aws_rds_cluster.postgresql.engine
  availability_zone       = "us-east-1a"
  publicly_accessible     = false
  

  tags = {
    Name = "techchallenge-instance"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}
