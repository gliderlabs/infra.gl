
data "aws_iam_policy_document" "infra" {
  statement {
    actions = [
      "s3:GetObject",
    ]
    effect = "Allow"
    resources = [
      "arn:aws:s3:::gl-infra/*",
    ]
    principals {
      type = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "infra" {
  bucket = "gl-infra"
  policy = "${data.aws_iam_policy_document.infra.json}"
}
