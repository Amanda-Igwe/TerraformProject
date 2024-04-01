resource "aws_iam_role" "coremarketing_role" {
  name = "coremarketing_redshift_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "redshift.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_policy" "coremarketing_policy" {
  name        = "coremarketing_redshift_policy"
  path        = "/"
  description = "A dedicated Policy for Core Marketing Redshift Cluster"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:List*",
          "s3:Get*"
        ]
        Effect   = "Allow"
        Resource = [
            "arn:aws:s3:::faker-raw-data",
            "arn:aws:s3:::faker-raw-data/spect*"
        ]
      },
      {
       Action = [
          "glue:*"
        ] 
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}



resource "aws_iam_role_policy_attachment" "coremarketing-role-policy" {
  role       = aws_iam_role.coremarketing_role.name
  policy_arn = aws_iam_policy.coremarketing_policy.arn
}


# Creating the redshift without the module

resource "aws_redshift_cluster" "coremarketing_demo" {
  cluster_identifier = "coremarketing-dept"
  database_name      = "coremarketing"
  master_username    = "demo"
  master_password    = "Password1"    # do not hardcode , do this later
  node_type          = "dc2.large"
  cluster_type       = "single-node"
  iam_roles          = [aws_iam_role.coremarketing_role.arn]
  publicly_accessible = true
  skip_final_snapshot = true

}

# Lets create our redshift using module now
# Hiding our password 
# we will first create the parameters using aws ssm for password
# then change the value afterwards using the random provider 

resource "aws_ssm_parameter" "coremarketing_dept_params" {
  name  = "coredmarketing_password"
  type  = "String"
  value = random_password.coremarketing_rs_password.result

}

# generating the password now using Random Provider 
# then going back to the aws ssm parameter to inject it

resource "random_password" "coremarketing_rs_password" {
  length           = 24
  special          = false
}


# using the module

module "coredata_redshift_demo" {
  source = "./module/redshift"
  coremarketing_redshift_cluster_identifier = "coremarketing-dept"
  coremarketing_redshift_db_name = "coremarketing"
  coremarketing_redshift_username = "demo"
  coremarketing_redshift_password = aws_ssm_parameter.coremarketing_dept_params.value
  coremarketing_redshift_node_type = "dc2.large"
  coremarketing_redshift_cluster_type = "single-node"
  coremarketing_redshift_iam_roles = [aws_iam_role.coremarketing_role.arn]
}