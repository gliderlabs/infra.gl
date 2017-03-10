resource "aws_s3_bucket" "manifold" {
  bucket = "gl-manifold"
  region = "us-east-1"
  acl = "private"
}
