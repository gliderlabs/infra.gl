data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "key" {
  key_name   = "sandbox"
  public_key = "${module.keys.matt}"
}

data "template_file" "cloud_config" {
  template = "${file("${path.module}/cloud-config.yml")}"

  vars {
    authorized_key = "${module.keys.jeff}"
  }
}

resource "aws_instance" "node" {
  count         = "${var.count}"
  instance_type = "${var.size}"
  ami           = "${data.aws_ami.ubuntu.id}"
  user_data     = "${data.template_file.cloud_config.rendered}"
  key_name      = "${aws_key_pair.key.key_name}"

  subnet_id = "${aws_subnet.main.id}"

  vpc_security_group_ids = [
    "${aws_security_group.default.id}",
    "${aws_security_group.docker_daemon.id}",
  ]

  tags {
    Name = "sandbox.node.${count.index+1}"
  }

  lifecycle {
    create_before_destroy = true
  }
}
