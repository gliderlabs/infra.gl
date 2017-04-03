resource "null_resource" "cluster" {
  depends_on = [
    "aws_route53_zone.manifold_infra_gl",
  ]
  triggers {
    vpc_id = "${aws_vpc.main.id}"
  }

  provisioner "local-exec" {
    command = <<EOT
      sleep 60
      export AWS_ACCESS_KEY_ID="$TF_VAR_manifold_access_key"
      export AWS_SECRET_ACCESS_KEY="$TF_VAR_manifold_secret_key"
      echo "${module.keys.gliderbot}" > /tmp/id_rsa.pub
      kops create cluster \
        --vpc ${aws_vpc.main.id} \
        --state s3://${aws_s3_bucket.manifold.id} \
        --zones ${var.region}a \
        --ssh-public-key /tmp/id_rsa.pub \
        --yes \
        ${aws_route53_zone.manifold_infra_gl.name}
EOT
  }
}

resource "null_resource" "cluster_ready" {
  depends_on = [
    "null_resource.cluster",
  ]

  provisioner "local-exec" {
    command = <<EOT
      sleep 120
      go run ${path.module}/scripts/wait.go --host api.${aws_route53_zone.manifold_infra_gl.name}
EOT
  }
}

resource "null_resource" "cluster_setup" {
  depends_on = [
    "null_resource.cluster",
    "null_resource.cluster_ready"
  ]
  triggers {
    vpc_id = "${aws_vpc.main.id}"
  }

  provisioner "local-exec" {
    command = <<EOT
      kubectl get nodes
      kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.5.0.yaml
    	kubectl apply -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/monitoring-standalone/v1.2.0.yaml
      kubectl apply -f ${path.module}/specs
EOT
  }
}
