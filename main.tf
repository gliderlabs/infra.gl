variable "access_key" {}
variable "secret_key" {}

variable "manifold_access_key" {}
variable "manifold_secret_key" {}

variable "sandbox_access_key" {}
variable "sandbox_secret_key" {}

module "dns" {
  source = "./dns"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"

  sandbox_ns = "${module.sandbox.name_servers}"
  manifold_ns = "${module.manifold.name_servers}"
}

module "sandbox" {
  source = "./sandbox"
  access_key = "${var.sandbox_access_key}"
  secret_key = "${var.sandbox_secret_key}"
}

module "manifold" {
  source = "./manifold"
  access_key = "${var.manifold_access_key}"
  secret_key = "${var.manifold_secret_key}"
}
