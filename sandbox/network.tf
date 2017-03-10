
resource "aws_subnet" "main" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "sandbox.sub.a"
  }
}

resource "aws_security_group" "default" {
  name   = "sandbox.sg.default"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "docker_daemon" {
  name   = "sandbox.sg.docker-daemon"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 2376
    to_port   = 2376
    protocol  = "tcp"

    cidr_blocks = [
      "${var.office_ip}",
      "10.1.0.0/16",
    ]
  }
}

resource "aws_network_acl" "dune" {
  vpc_id     = "${var.vpc_id}"
  subnet_ids = ["${aws_subnet.main.id}"]

  # Ephemeral Ports
  egress {
    rule_no    = 30
    from_port  = 1024
    to_port    = 65535
    protocol   = "tcp"
    cidr_block = "10.1.0.0/16"
    action     = "allow"
  }

  # Following is required to isolate sandbox's outbound traffic from the vpc.
  # A rule can be created before this to allow any necessary traffic.
  egress {
    rule_no    = 50
    protocol   = "all"
    cidr_block = "10.1.0.0/16"
    action     = "deny"
    from_port  = 0
    to_port    = 0
  }

  egress {
    rule_no    = 100
    protocol   = "all"
    cidr_block = "0.0.0.0/0"
    action     = "allow"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    rule_no    = 100
    protocol   = "all"
    cidr_block = "0.0.0.0/0"
    action     = "allow"
    from_port  = 0
    to_port    = 0
  }

  tags {
    Name = "sandbox"
  }
}
