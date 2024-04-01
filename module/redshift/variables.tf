variable "coremarketing_redshift_cluster_identifier" {}
variable "coremarketing_redshift_db_name" {}
variable "coremarketing_redshift_username" {}
variable "coremarketing_redshift_password" {}
variable "coremarketing_redshift_iam_roles" {}


variable "coremarketing_redshift_node_type" {
  default = "dc2.large"
}


variable "coremarketing_redshift_cluster_type" {
  default = "single-node"
}


variable "coremarketing_redshift_publicly_accessible" {
  default = true
}
 

variable "coremarketing_redshift_skip_final_shot" {
  default = true
}