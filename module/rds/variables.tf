variable "demo_dept_db_identifier" {}
variable "demo_dept_db_name" {}
variable "demo_dept_db_username" {}
variable "demo_dept_db_password" {}

variable "demo_dept_db_storage" {
  default = "10"
}


variable "demo_dept_db_engine_version" {
    default = "16.1"
}


variable "demo_dept_db_instance_class" {
    default = "db.t3.micro"
}


variable "demo_dept_db_public_accessible" {
  default = "false"
}