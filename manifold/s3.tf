resource "aws_s3_bucket" "manifold" {
  bucket = "gl-infra-manifold"
  region = "us-east-1"

  versioning {
    enabled = true
  }
}
