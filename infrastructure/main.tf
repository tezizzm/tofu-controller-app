module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name                 = "myapp-vpc"
  cidr                 = var.vpc_cidr
  azs                  = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets      = var.private_subnets
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow inbound Postgres"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = module.vpc.private_subnets
  tags = {
    Name = "rds-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier              = "myapp-db"
  engine                  = "postgres"
  engine_version          = "14.9"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  port                    = 5432
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
}
