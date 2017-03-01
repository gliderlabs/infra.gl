resource "aws_iam_role" "dev_admin" {
    name = "DevAdmin"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::233115379322:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "aws:username": [
            "matt",
            "jeff"
          ]
        },
        "Bool": {
          "aws:MultiFactorAuthPresent": "true"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "dev_admin" {
    name = "AdministratorAccess"
    roles = ["${aws_iam_role.dev_admin.name}"]
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
