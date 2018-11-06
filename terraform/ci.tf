resource "digitalocean_ssh_key" "ci" {
  name = "CI Server"
  public_key = "${file(var.public_key)}"
}

resource "digitalocean_droplet" "ci" {
    image = "docker-18-04"
    name = "ci"
    region = "lon1"
    size = "s-1vcpu-1gb"
    ssh_keys = [
        "${digitalocean_ssh_key.ci.fingerprint}"
    ]
    connection {
        user = "root"
        type = "ssh"
        private_key = "${file(var.private_key)}"
        timeout = "2m"
    }
    provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get -y install python python-pip",
            "sudo pip install docker"
        ]
    }
}

output "ip" {
    value = "${digitalocean_droplet.ci.ipv4_address}"
}
