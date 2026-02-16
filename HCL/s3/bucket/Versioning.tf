# main.tf
resource "aws_s3_bucket" "my_bucket2" {
  bucket  = "my-unique-bucket-name7y777"
  tags    = {
  Name           = "MyS3Bucket"
  Environment    = "Production"
  }
}
resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}