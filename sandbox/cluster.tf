provider "aws" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "node" {
  count         = 2
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.size}"
  key_name      = "matt@lanciv.com"
  user_data     = "${file("cloud-config.yml")}"

  subnet_id = "${aws_subnet.main.id}"

  vpc_security_group_ids = [
    "${aws_security_group.default.id}",
    "${aws_security_group.docker_daemon.id}",
  ]

  tags {
    Name = "dune.node.${count.index+1}"
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["aws_internet_gateway.main"]
}

variable "size" {
  default = "t2.medium"
}

output "public_dns" {
  value = ["${aws_instance.node.*.public_dns}"]
}

output "public_ips" {
  value = ["${aws_instance.node.*.public_ip}"]
}

output "private_ips" {
  value = ["${aws_instance.node.*.private_ip}"]
}
