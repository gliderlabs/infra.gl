resource "aws_vpc_peering_connection_accepter" "sandbox" {
  vpc_peering_connection_id = "${var.sandbox_vpc_peer}"
  auto_accept               = true
}

data "aws_route_table" "main" {
  route_table_id = "${var.manifold_route_table}"
  vpc_id         = "${var.manifold_vpc}"
}

resource "aws_route" "manifold_dune" {
  route_table_id            = "${data.aws_route_table.main.vpc_id}"
  destination_cidr_block    = "${var.sandbox_cidr}"
  vpc_peering_connection_id = "${var.sandbox_vpc_peer}"
}
