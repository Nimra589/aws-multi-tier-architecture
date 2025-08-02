resource "aws_security_group" "db" {
  vpc_id = var.vpc_id
  name   = "db-sg"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db" {
  identifier           = "multi-tier-db"
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  username             = var.db_username
  password             = var.db_password
  allocated_storage    = 20
  vpc_security_group_ids = [aws_security_group.db.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnets.name
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "db_subnets" {
  name       = "db-subnet-group"
  subnet_ids = var.private_subnet_ids
}

output "db_endpoint" {
  value = aws_db_instance.db.endpoint
}
