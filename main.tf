module "vm1" {
  source          = "./modules/instance"
  name            = "vm1"
  subnet_id       = data.yandex_vpc_subnet.subnet.id
  image_id        = data.yandex_compute_image.ubuntu.id
  ssh_user        = "ubuntu"
}

module "vm2" {
  source          = "./modules/instance"
  name            = "vm2"
  subnet_id       = data.yandex_vpc_subnet.subnet.id
  image_id        = data.yandex_compute_image.ubuntu.id
  ssh_user        = "ubuntu"
}

module "vm3" {
  source          = "./modules/instance"
  name            = "vm3"
  subnet_id       = data.yandex_vpc_subnet.subnet.id
  image_id        = data.yandex_compute_image.ubuntu.id
  ssh_user        = "ubuntu"
}

resource "local_file" "inventory" {
  depends_on = [
    module.vm1, 
    module.vm2,
    module.vm3
  ]

  filename = "${path.module}/inventory.ini"

  content = <<EOF
[test]
vm1 ansible_host=${module.vm1.external_ip} ansible_user=${module.vm1.ssh_user}
vm2 ansible_host=${module.vm2.external_ip} ansible_user=${module.vm2.ssh_user}
vm3 ansible_host=${module.vm3.external_ip} ansible_user=${module.vm3.ssh_user}
EOF
}

data "yandex_vpc_subnet" "subnet" {
  name = "subnet"
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}


