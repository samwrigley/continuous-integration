variable "digitalocean_token" {}
variable "public_key" {}
variable "private_key" {}

provider "digitalocean" {
  token = "${var.digitalocean_token}"
}