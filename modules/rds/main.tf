
# 1. DB Subnet Group

resource "aws_db_subnet_group" "db_subnet" {
  name       = var.db_sub_name
  subnet_ids = [var.pri_sub_5a_id, var.pri_sub_6b_id]  # Replace with your subnet IDs

  tags = {
    Name = "db-subnet-group"
  }
}

#########################
# 2. Primary MySQL DB
#########################
resource "aws_db_instance" "db" {
  identifier              = "bookdb-instance"
  engine                  = "mysql"
  engine_version          = "8.0.35"
  instance_class          = "db.t3.micro"
  allocated_storage       = 20
  username                = var.db_username
  password                = var.db_password
  db_name                 = var.db_name
  multi_az                = true
  storage_type            = "gp2"
  storage_encrypted       = false
  publicly_accessible     = false
  skip_final_snapshot     = true
  backup_retention_period = 7

  vpc_security_group_ids  = [var.db_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.db_subnet.name

  tags = {
    Name = "bookdb-instance"
  }
}

#########################
# 3. Read Replica
#########################
resource "aws_db_instance" "read_replica" {
  replicate_source_db     = aws_db_instance.db.id
  instance_class          = "db.t3.micro"
  engine                  = "mysql"
  publicly_accessible     = false
  vpc_security_group_ids  = [var.db_sg_id]

  depends_on = [aws_db_instance.db]

  tags = {
    Name = "bookdb-read-replica"
  }
}
