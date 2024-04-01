#Creating an AWS Relational Database without module 

# resource "aws_db_instance" "project_db" {
#   allocated_storage    = 10
#   db_name              = "project_demo_db"
#   identifier           = "demo-dept-db"
#   engine               = "postgres"
#   engine_version       = "16.1"
#   instance_class       = "db.t3.micro"
#   username             = "demo"
#   password             = "password"    # very wrong practice of hardcoding the password, we will change this.
#   skip_final_snapshot  = true
#   publicly_accessible  = true

# }

#Creating an AWS Relational Database with module 

# module "coredata_db_demo" {
#   source = "./module/rds"
#   demo_dept_db_identifier = "coredata-demo"
#   demo_dept_db_name = "coredata"
#   demo_dept_db_username = "demo"
#   demo_dept_db_password = "password"
#   demo_dept_db_public_accessible = true
# }



#creating a new database without hardcoding the password.

# module "coremarketing_db_demo" {
#   source = "./module/rds"
#   demo_dept_db_identifier = "coremarketing-demo"
#   demo_dept_db_name = "coremarketing"
#   demo_dept_db_username = "demo"  
#   demo_dept_db_password = aws_ssm_parameter.demo_dept_params.value   # hiding the sensitive password  
#   demo_dept_db_public_accessible = true
# }


# we will first create the parameters using aws ssm for username and password
# then change the value afterwards using the random provider 


resource "aws_ssm_parameter" "demo_dept_params" {
  name  = "coredata_password"
  type  = "String"
  value = random_password.coremarketing_db_password.result

}

# generating the password now using Random Provider 
# then going back to the aws ssm parameter to inject it

resource "random_password" "coremarketing_db_password" {
  length           = 24
  special          = false
}