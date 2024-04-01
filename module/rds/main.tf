
resource "aws_db_instance" "project_demo_db" {
  allocated_storage    = var.demo_dept_db_storage
  db_name              = var.demo_dept_db_name
  identifier           = var.demo_dept_db_identifier
  engine               = "postgres"
  engine_version       = var.demo_dept_db_engine_version
  instance_class       = var.demo_dept_db_instance_class
  username             = var.demo_dept_db_username
  password             = var.demo_dept_db_password    # correct password method. without hardcoding and keeping it open
  skip_final_snapshot  = true
  publicly_accessible  = var.demo_dept_db_public_accessible

}