variable "access_key" {}
variable "secret_key" {}

/*variable "manifold_access_key" {}
variable "manifold_secret_key" {}

variable "sandbox_access_key" {}
variable "sandbox_secret_key" {}*/

module "dns" {
  source = "./dns"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

output "dns" {
  value = "${module.dns.name_servers}"
}
