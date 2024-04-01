#Creating an AWS S3 Bucket without a module
resource "aws_s3_bucket" "amaa_demo" {
  bucket = "amanda-project-demo-bucket"
}


#Creating an AWS S3 Bucket with a module

module "amaa_demo_test" {
  source = "./module/s3"
  demo_dept_bucket_name = "coredata-demo"
}
