resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "sandbox.vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  depends_on = ["aws_vpc.main"]

  tags {
    Name = "sandbox.ig"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  gateway_id             = "${aws_internet_gateway.main.id}"
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_subnet" "main" {
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "sandbox.sub.a"
  }
}

resource "aws_security_group" "default" {
  name   = "sandbox.sg.default"
  vpc_id = "${aws_vpc.main.id}"

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
  vpc_id = "${aws_vpc.main.id}"

  ingress {
    from_port = 2376
    to_port   = 2376
    protocol  = "tcp"

    cidr_blocks = [
      "${var.office_ip}",
      "10.1.10.0/24",
      "10.1.20.0/24",
      "10.1.30.0/24",
      "100.64.0.0/10",
      "172.20.0.0/16",
    ]
  }
}

resource "aws_network_acl" "dune" {
  vpc_id     = "${aws_vpc.main.id}"
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

resource "aws_vpc_peering_connection" "manifold" {
  vpc_id        = "${aws_vpc.main.id}"
  peer_vpc_id   = "${var.manifold_vpc}"
  peer_owner_id = "${var.manifold_aws_account_id}"

  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "manifold_containers" {
  route_table_id            = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block    = "${var.manifold_containers_cidr}"           #"100.64.0.0/10"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.manifold.id}"
}

resource "aws_route" "manifold_nodes" {
  route_table_id            = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block    = "${var.manifold_nodes_cidr}"                #"172.20.0.0/16"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.manifold.id}"
}
