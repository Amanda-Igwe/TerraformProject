
resource "aws_redshift_cluster" "coremarketing_demo" {
  cluster_identifier = var.coremarketing_redshift_cluster_identifier
  database_name      = var.coremarketing_redshift_db_name
  master_username    = var.coremarketing_redshift_username
  master_password    = var.coremarketing_redshift_password   
  node_type          = var.coremarketing_redshift_node_type
  cluster_type       = var.coremarketing_redshift_cluster_type
  iam_roles          = var.coremarketing_redshift_iam_roles
  publicly_accessible = var.coremarketing_redshift_publicly_accessible
  skip_final_snapshot = var.coremarketing_redshift_skip_final_shot

}